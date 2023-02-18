#include <ArduinoBLE.h>

const int ledPin = LED_BUILTIN; // set ledPin to on-board LED

BLEService ledService("19B10010-E8F2-537E-4F6C-D104768A1214"); // create service

// create switch characteristic and allow remote device to read and write
BLEByteCharacteristic ledCharacteristic("19B10011-E8F2-537E-4F6C-D104768A1214", BLERead | BLEWrite);
// create button characteristic and allow remote device to get notifications
BLEByteCharacteristic buttonCharacteristic("19B10012-E8F2-537E-4F6C-D104768A1214", BLERead | BLEWrite | BLENotify);

void setup() {
  Serial.begin(9600);
  //while (!Serial) delay(10);  // for nrf52840 with native usb
  pinMode(ledPin, OUTPUT); // use the LED as an output
  Serial.println("Hello, I am awake!");
  setLED(false);
  //setLED(true);

  if (!BLE.begin()) {
    Serial.println("starting Bluetooth® Low Energy module failed!");
    while (1);
  }

  BLE.setEventHandler(BLEConnected, blePeripheralConnectHandler);

  // set the local name peripheral advertises
  BLE.setLocalName("routine");
  // set the UUID for the service this peripheral advertises:
  BLE.setAdvertisedService(ledService);

  // add the characteristics to the service
  ledService.addCharacteristic(ledCharacteristic);
  ledService.addCharacteristic(buttonCharacteristic);

  // add the service
  BLE.addService(ledService);

  ledCharacteristic.writeValue(0);
  buttonCharacteristic.writeValue(0);

  Serial.println("Bluetooth® device active, waiting for connections...");

  while (1) {
    BLE.advertise();
    if (buttonCharacteristic.subscribed()) {
      buttonCharacteristic.writeValue(1);
      byte tmp = 0;
      buttonCharacteristic.readValue(tmp);
      Serial.println((int)tmp);
      break;
    }
  }
  Serial.println("sending data - done");
  setLED(true);
  delay(1000); // delay seems important to apply settings, before going to System OFF
  nrf_gpio_cfg_sense_input(AIN4, NRF_GPIO_PIN_PULLUP, NRF_GPIO_PIN_SENSE_LOW);
  delay(2000); // delay seems important to apply settings, before going to System OFF
  // Trigger System OFF
  Serial.println("Going to System OFF");
  NRF_POWER->SYSTEMOFF = 1;
}

void loop() {}

void blePeripheralConnectHandler(BLEDevice central) {
  Serial.print("Connected event, central: ");
  Serial.println(central.address());
}

void setLED(bool on)
{
  digitalWrite(LED_BUILTIN, on ? HIGH : LOW);
}
