#include <Arduino.h>
#include <WiFi.h>
#include <ArduinoBLE.h>
#include <Firebase_ESP_Client.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"
#include "config.h"
#include "FS.h"
#include "SPIFF_funcs.h"
#include "SPIFFS.h"
#include <Regexp.h>

#define RoutineInhaler "routine"
#define AcuteInhaler "acute"

#define FORMAT_SPIFFS_IF_FAILED true
#define API_KEY "AIzaSyDkSVQ_DtGwgUFLb-a1js_61doXrEHXxPM"
#define FIREBASE_PROJECT_ID "respi-track"
#define USER_EMAIL "alon@gmail.com"
#define USER_PASSWORD "123456"
#define MAX_PRESSES 200

bool rtcIrq = false;

TTGOClass *watch;
AXP20X_Class *power;
TFT_eSPI *tft;
char buf[128];
char wifiTime[128];
String date;
String snooze = "";
int i = 0;

//const char *ssid = "Pixel_3902";
//const char *password = "a185a10c8f20";
const char *ssid = "Snow";
const char *password = "12345678";
bool isWifiConnected = false;
String syncTime = "02:00:00";
int press_routine = 13;
int inhalerNum_routine = 1;
int press_acute = 13;
int inhalerNum_acute = 1;
bool isRoutine = true;

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

void match_callback(const char *match,         // matching string (not null-terminated)
                    const unsigned int length, // length of matching string
                    const MatchState &ms)      // MatchState in use (to get captures)
{
  char cap[11]; // must be large enough to hold captures

  for (byte i = 0; i < ms.level; i++)
  {
    if (i % 2 == 0)
    {
      ms.GetCapture(cap, i);
      if (!SPIFFS.exists("/alarms_log.txt"))
        writeFile(SPIFFS, "/alarms_log.txt", cap);
      else
        appendFile(SPIFFS, "/alarms_log.txt", cap);
      appendFile(SPIFFS, "/alarms_log.txt", "\n");
    }
  }
}

void getAlarmsFromDatabase()
{
  deleteFile(SPIFFS, "/alarms_log.txt");
  String collectionId = "alarms";
  String mask = "time";
  if (Firebase.Firestore.listDocuments(&fbdo, FIREBASE_PROJECT_ID, "", collectionId.c_str(), 50, "", "", mask, false))
  {
    Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
    char *buf = new char[strlen(fbdo.payload().c_str()) + 1];
    strcpy(buf, fbdo.payload().c_str());
    MatchState ms(buf);
    ms.GlobalMatch("([0-9]+:[0-9]+:[0-9]+)(\")", match_callback);
    readFile(SPIFFS, "/alarms_log.txt");
    delete[] buf;
  }
  else
    Serial.println(fbdo.errorReason());
  isWifiConnected = true;
}
void sendInhalersToDatabase(const char *log_name, String documentPath){
  File file = SPIFFS.open(log_name);
      if (!file)
      {
        Serial.println("Failed to open file for reading");
        return;
      }

      while (file.available())
      {
        String pressNum = file.readStringUntil(' ');
        String dateTime = file.readStringUntil('\n');
        // String documentPath = inhaler_name;

        FirebaseJson content;
        content.set("fields/dateTime/stringValue", dateTime);

        if (pressNum.toInt() % MAX_PRESSES == 0)
        {
          if (isRoutine)
            inhalerNum_routine++;
          else
            inhalerNum_acute++;
        }
        int inhalerNum = isRoutine ? inhalerNum_routine : inhalerNum_acute;
        content.set("fields/inhalerNum/stringValue", String(inhalerNum));

        if (Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), content.raw(), "dateTime,inhalerNum"))
        {
          Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
        }
        else
          Serial.println(fbdo.errorReason());

        if (Firebase.Firestore.createDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), content.raw()))
        {
          Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
        }
        else
          Serial.println(fbdo.errorReason());
      }
      file.close();
      deleteFile(SPIFFS, log_name);

}
void isTimeInAlarms(fs::FS &fs, String now_time)
{
  fs::File file = fs.open("/alarms_log.txt");
  if (!file)
  {
    Serial.println("Failed to open file for reading");
    return;
  }
  while (file.available())
  {
    String alarm = file.readStringUntil('\n');
    int16_t x;
    int16_t y;
    if (now_time == alarm || now_time == snooze)
    {
      while (watch->getTouch(x, y) == false)
      {
        watch->shake();
        tft->setTextColor(TFT_WHITE);
        tft->fillRect(0, 0, 120, 240, TFT_GREEN);
        tft->fillRect(120, 0, 120, 240, TFT_RED);
        tft->drawString("TAKEN", 8, 45, 2);
        tft->drawString("SNOOZE", 128, 45, 2);
        delay(500);
      }
      Serial.print("point touched: ");
      Serial.print(x);
      Serial.print(", ");
      Serial.println(y);
      if (x > 0 && x < 120)
      {
        Serial.println("Taken");
      }
      else
      {
        Serial.println("Snooze");
        snooze = now_time;
        snooze[6] = char(int(now_time[6]) + 1);
        Serial.println(snooze);
      }
      tft->fillScreen(TFT_BLACK);
      break;
    }
  }
  file.close();
}

void dailySync(String now_time)
{
  if (now_time == syncTime){
    if (WiFi.status() == WL_CONNECTED)
    {
      isWifiConnected = true;
      Serial.printf("Connected to %s ", ssid);
      strcpy(wifiTime, buf);
      if (WiFi.status() == WL_CONNECTED && Firebase.ready())
      {
        getAlarmsFromDatabase();
      }
    }
  } 
}
void diaplayTime()
{
  watch->power->adc1Enable(AXP202_VBUS_VOL_ADC1 | AXP202_VBUS_CUR_ADC1 | AXP202_BATT_CUR_ADC1 | AXP202_BATT_VOL_ADC1, true);
  tft->setTextColor(TFT_BLACK);
  //tft->drawString("Respi Track", 50, 50, 4);
  tft->fillRoundRect(50, 50, 120, 30, 15, TFT_CYAN);
  tft->drawString("Sync", 80, 55, 4);
  int16_t x;
  int16_t y;
  if(watch->getTouch(x, y) == true){
    if(x > 50 && x < 200 && y > 50 && y < 100){
      tft->fillRoundRect(50, 50, 120, 30, 15, TFT_RED);
      tft->drawString("NO WiFi", 60, 55, 4);
      delay(2000);
    if (WiFi.status() == WL_CONNECTED)
    {
      Serial.printf("Connected to %s ", ssid);
      tft->fillRoundRect(50, 50, 120, 30, 15, TFT_RED);
      tft->drawString("Sync", 80, 55, 4);
      if (WiFi.status() == WL_CONNECTED && Firebase.ready())
      {
        tft->fillRoundRect(50, 50, 120, 30, 15, TFT_CYAN);
        tft->drawString("Sync", 80, 55, 4);
        getAlarmsFromDatabase();
        if (SPIFFS.exists("/routine_inhaler_log.txt"))
          sendInhalersToDatabase("/routine_inhaler_log.txt", "Routine/");
        if (SPIFFS.exists("/acute_inhaler_log.txt"))
          sendInhalersToDatabase("/acute_inhaler_log.txt", "Acute/");
        strcpy(wifiTime, buf);
        isWifiConnected = true;
      }
    }
    }
  }
  if (isWifiConnected)
  {
    tft->setTextColor(TFT_WHITE, TFT_BLACK);
    tft->drawString("Last WIFI connection was at", 30, 183, 2);
    tft->drawString(wifiTime, 70, 205, 4);
  }

  tft->setTextColor(TFT_CYAN, TFT_BLACK);
  RTC_Date t_now = watch->rtc->getDateTime();
  date = String(t_now.day) + "." + String(t_now.month) + "." + String(t_now.year);
  String now_time = watch->rtc->formatDateTime();
  snprintf(buf, sizeof(buf), "%s", now_time);
  tft->drawString(buf, 5, 110, 7);
  dailySync(now_time);
  isTimeInAlarms(SPIFFS, now_time);
  if (rtcIrq)
  {
    rtcIrq = 0;
    detachInterrupt(RTC_INT_PIN);
    watch->rtc->resetAlarm();
    int i = 3;
    while (i--)
    {
      tft->fillScreen(TFT_RED);
      tft->setTextColor(TFT_WHITE, TFT_RED);
      tft->drawString("RTC Alarm", 60, 118, 4);
      delay(500);
      tft->fillScreen(TFT_BLACK);
      tft->setTextColor(TFT_WHITE, TFT_BLACK);
      tft->drawString("RTC Alarm", 60, 118, 4);
      delay(500);
    }
  }
  // Display Battery Level
  tft->setTextSize(1);
  tft->setTextColor(TFT_GREEN, TFT_BLACK);
  int per = watch->power->getBattPercentage();
  tft->drawString(String(per) + "%", 190, 2, 2);

  // Turn off the battery adc
  // watch->power->adc1Enable(AXP202_VBUS_VOL_ADC1 | AXP202_VBUS_CUR_ADC1 | AXP202_BATT_CUR_ADC1 | AXP202_BATT_VOL_ADC1, false);

  delay(1000);
}

void updateData(byte value, const char *log_name, String documentPath)
{
  if (isRoutine)
    press_routine = (int)value + press_routine;
  else
    press_acute = (int)value + press_acute;
  int press = isRoutine ? press_routine : press_acute;

  Serial.print("counter from button: ");
  Serial.println(press);
  String dateTime = String(press) + " " + String(buf) + " " + date + "\n";
  if (!SPIFFS.exists(log_name))
  {
    writeFile(SPIFFS, log_name, dateTime.c_str());
    // isWifiConnected = false;
  }
  else
    appendFile(SPIFFS, log_name, dateTime.c_str());
  readFile(SPIFFS, log_name);
  if (WiFi.status() == WL_CONNECTED)
  {
    isWifiConnected = true;
    Serial.printf("Connected to %s ", ssid);
    strcpy(wifiTime, buf);
    if (WiFi.status() == WL_CONNECTED && Firebase.ready())
    {
      sendInhalersToDatabase(log_name, documentPath);
      getAlarmsFromDatabase();
    }
  }
}

void setup()
{
  Serial.begin(9600);

  if (!SPIFFS.begin(FORMAT_SPIFFS_IF_FAILED))
  {
    Serial.println("SPIFFS Mount Failed");
    return;
  }
  // deleteFile(SPIFFS, "/routine_inhaler_log.txt");
  // deleteFile(SPIFFS, "/acute_inhaler_log.txt");
  //readFile(SPIFFS, "/alarms_log.txt");
  // deleteFile(SPIFFS, "/inhaler_log.txt");
  // deleteFile(SPIFFS, "/alarms_log.txt");
  // writeFile(SPIFFS, "/alarms_log.txt", "15:35:00\n");
  // appendFile(SPIFFS, "/alarms_log.txt", "15:36:00\n");
  // listDir(SPIFFS, "/", 0);

  // Get TTGOClass instance
  watch = TTGOClass::getWatch();
  watch->begin();

  watch->openBL();
  watch->setBrightness(80);
  watch->motor_begin();

  // attach touch screen interrupt pin
  pinMode(TP_INT, INPUT);

  // Receive objects for easy writing
  tft = watch->tft;

  watch->power->setPowerOutPut(AXP202_EXTEN, AXP202_OFF);
  watch->power->setPowerOutPut(AXP202_DCDC2, AXP202_OFF); // NO USE
  watch->power->setPowerOutPut(AXP202_LDO3, AXP202_OFF);  // Backplane power supply
  watch->power->setPowerOutPut(AXP202_LDO4, AXP202_OFF);  // S76/78G Backplane only

  pinMode(RTC_INT_PIN, INPUT_PULLUP);
  attachInterrupt(
      RTC_INT_PIN, []
      { rtcIrq = 1; },
      FALLING);
  watch->rtc->disableAlarm();
  watch->rtc->setDateTime(2022, 11, 19, 9, 30, 00);
  watch->rtc->setAlarmByMinutes(1);
  watch->rtc->enableAlarm();

  if (!BLE.begin())
  {
    Serial.println("starting Bluetooth® Low Energy module failed!");
    while (1)
      ;
  }

  BLE.scanForUuid("19B10010-E8F2-537E-4F6C-D104768A1214");

  WiFi.begin(ssid, password);

  config.api_key = API_KEY;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.token_status_callback = tokenStatusCallback;

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop()
{
  diaplayTime();
  // watch->closeBL();
  BLEDevice peripheral = BLE.available();
  // Serial.print(peripheral);
  // Serial.println(" - we are disconnected");
  if (peripheral)
  {
    // discovered a peripheral, print out address, local name, and advertised service
    Serial.print("Found ");
    Serial.print(peripheral.address());
    Serial.print(" '");
    Serial.print(peripheral.localName());
    Serial.print("' ");
    Serial.print(peripheral.advertisedServiceUuid());
    Serial.println();
    String selected_inhaler = peripheral.localName();
    if (selected_inhaler != RoutineInhaler && selected_inhaler != AcuteInhaler)
      return;

    isRoutine = selected_inhaler != RoutineInhaler ? false : true;
    BLE.stopScan();

    Serial.println("Connecting ...");
    if (peripheral.connect())
    {
      Serial.println("Connected");
    }
    else
    {
      Serial.println("Failed to connect!");
      return;
    }

    Serial.println("Discovering attributes ...");
    if (peripheral.discoverService("19B10010-E8F2-537E-4F6C-D104768A1214"))
    {
      Serial.println("Attributes discovered");
    }
    else
    {
      Serial.println("Attribute discovery failed!");
      peripheral.disconnect();
      return;
    }

    BLECharacteristic buttonCharacteristic = peripheral.characteristic("19B10012-E8F2-537E-4F6C-D104768A1214");
    if (!buttonCharacteristic)
    {
      Serial.println("no button characteristic found!");
      peripheral.disconnect();
      return;
    }
    else if (!buttonCharacteristic.canSubscribe())
    {
      Serial.println("button characteristic is not subscribable!");
      peripheral.disconnect();
      return;
    }
    else if (!buttonCharacteristic.subscribe())
    {
      Serial.println("subscription failed!");
      peripheral.disconnect();
      return;
    }
    else
      Serial.println("Subscribed");

    byte value = 0;
    while (!buttonCharacteristic.valueUpdated())
    {
    }
    buttonCharacteristic.readValue(value);
    const char *log_name = isRoutine ? "/routine_inhaler_log.txt" : "/acute_inhaler_log.txt";
    String inhaler_name = isRoutine ? "Routine" : "Acute";
    updateData(value, log_name, inhaler_name);
  }
  BLE.scanForUuid("19B10010-E8F2-537E-4F6C-D104768A1214");
}
