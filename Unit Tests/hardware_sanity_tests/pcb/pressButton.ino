const int buttonPin = 6;     // pushbutton connected to digital pin 6
int previuosButtonState = HIGH;
int buttonState = 0;         // variable for reading the pushbutton status
 
void setup() {
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT_PULLUP);
  Serial.begin(9600);
}
 
void loop() {
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);

  // check if the pushbutton is pressed. If it is, the buttonState is HIGH:
  if((previuosButtonState != buttonState)&&(buttonState != HIGH)){
    Serial.println("I pressed the button :)");
  }
  digitalWrite(LED_BUILTIN, buttonState);
  previuosButtonState = buttonState;
}
