#include "Wire.h"
#include "wiring.h"

const int ledPin = LED_BUILTIN; // set ledPin to on-board LED
const int buttonPin = 1; // set buttonPin to digital pin 1

volatile uint8_t interruptCount = 0; // Amount of received interrupts
uint8_t prevInterruptCount = 0; // Interrupt Counter from last loop

void setup() {
  Serial.begin(9600);
  while ( !Serial ) delay(10);   // for nrf52840 with native usb
  pinMode(ledPin, OUTPUT); // use the LED as an output

  Serial.println("Hello, I am awake!");
  pinMode(buttonPin, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(buttonPin), interruptHandler, RISING);
}

void loop() {
  setLED(false);
  Serial.print("Interrupt Counter: ");
  Serial.println(interruptCount);

  if (interruptCount > prevInterruptCount) {
    Serial.println("Interrupt received!");
  }
  prevInterruptCount = interruptCount;

  if (interruptCount >= 3) {
    // Trigger System OFF after 3 interrupts
    goToPowerOff();
  }
  delay(500);
}

void goToPowerOff() {
  Serial.println("Going to System OFF");
  setLED(true);
  delay(1000);
  nrf_gpio_cfg_sense_input(digitalPinToInterrupt(buttonPin), NRF_GPIO_PIN_PULLDOWN, NRF_GPIO_PIN_SENSE_HIGH);
  NRF_POWER->SYSTEMOFF = 1;
}

void interruptHandler() {
  interruptCount++;
}

void setLED(bool on)
{
  // data = 1 -> LED = On
  // data = 0 -> LED = Off
  digitalWrite(LED_BUILTIN, on ? HIGH : LOW);
}
