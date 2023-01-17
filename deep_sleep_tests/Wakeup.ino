#include <Wire.h>
#include <wiring.h>
#define BUTTON_PIN 6

const int ledPin = LED_BUILTIN; // set ledPin to on-board LED
uint8_t wake_logic = 0;

void setup() {
  Serial.begin(9600);
  while ( !Serial ) delay(10);   // for nrf52840 with native usb
  pinMode(ledPin, OUTPUT); // use the LED as an output
  pinMode(BUTTON_PIN, INPUT_PULLUP_SENSE);

  Serial.println("Hello, I am awake!");
  setLED(false);
  delay(5000);
}

void loop() {
  if (millis() < 10000) {
    Serial.println("going to deep sleep...");
    delay(2000);
    setLED(true);
    systemOff(BUTTON_PIN, wake_logic);
    Serial.println("Dead area");
  }
}

void setLED(bool on)
{
  // data = 1 -> LED = On
  // data = 0 -> LED = Off
  digitalWrite(LED_BUILTIN, on ? HIGH : LOW);
}
