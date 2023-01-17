#include <Wire.h>

//#define BUTTON_PIN 1
int i = 0;
volatile uint8_t interruptCount = 0; // Amount of received interrupts
const int buttonPin = 1; // set buttonPin to digital pin 1

void interruptHandler() {
  interruptCount++;
}

void setup() {
  Serial.begin(9600);
  while ( !Serial ) delay(10);   // for nrf52840 with native usb

  Serial.println("Hello, I am awake!");
  pinMode(buttonPin, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(buttonPin), interruptHandler, RISING);
}

void loop() {
  i++;
  Serial.println(i);
  delay(1000);
  setLED(i % 2);
  if (i > 5) {
    Serial.println("Going to deep sleep...");
    delay(1000);
  nrf_gpio_cfg_sense_input(digitalPinToInterrupt(buttonPin), NRF_GPIO_PIN_PULLDOWN, NRF_GPIO_PIN_SENSE_HIGH);
    NRF_POWER->SYSTEMOFF = 1;
    Serial.println("Dead area");
  }
}

void setLED(bool on)
{
  // data = 1 -> LED = On
  // data = 0 -> LED = Off
  digitalWrite(LED_BUILTIN, on ? HIGH : LOW);
}
