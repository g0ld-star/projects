// Array to store the color of the buttons
color[] buttonColors = new color[10];
// Rectangle positions and sizes
int buttonWidth = 100;
int buttonHeight = 100;
int startX = 50;
int startY = 50;
int buttonSpacing = 20;

// Variables to track screen mode
boolean onButtonScreen = true; // If true, we're showing the buttons; false for showing the background color

// Back button properties
int backButtonX = 350;
int backButtonY = 500;
int backButtonWidth = 100;
int backButtonHeight = 50;

void setup() {
  size(800, 600); // Set the window size
  noStroke();
  
  // Initialize the button colors
  buttonColors[0] = color(255, 0, 0);    // Red
  buttonColors[1] = color(0, 255, 0);    // Green
  buttonColors[2] = color(0, 0, 255);    // Blue
  buttonColors[3] = color(255, 255, 0);  // Yellow
  buttonColors[4] = color(255, 165, 0);  // Orange
  buttonColors[5] = color(0, 255, 255);  // Cyan
  buttonColors[6] = color(255, 0, 255);  // Magenta
  buttonColors[7] = color(255, 255, 255); // White
  buttonColors[8] = color(0, 0, 0);      // Black
  buttonColors[9] = color(128, 0, 128);  // Purple
}

void draw() {
  if (onButtonScreen) {
    // Default background when on the button screen
    background(200);
    
    // Draw the buttons
    for (int i = 0; i < buttonColors.length; i++) {
      fill(buttonColors[i]);
      rect(startX + (i % 5) * (buttonWidth + buttonSpacing), // X position
           startY + (i / 5) * (buttonHeight + buttonSpacing), // Y position
           buttonWidth, buttonHeight); // Button size
    }
    
    // Draw the back button (which won't be visible until after a button is pressed)
    fill(200); // Light background for the back button
    rect(backButtonX, backButtonY, backButtonWidth, backButtonHeight);
    fill(0); // Black text for the back button
    textSize(16);
    textAlign(CENTER, CENTER);
    text("Back", backButtonX + backButtonWidth / 2, backButtonY + backButtonHeight / 2);
  } else {
    // After a button is pressed, show the background color of the button
    // No button screen anymore, just the background color
    // The background color is already set in the mousePressed() function
    fill(255);
    rect(backButtonX, backButtonY, backButtonWidth, backButtonHeight); // Draw the back button
    fill(0); // Text color for "Back" label
    textSize(16);
    textAlign(CENTER, CENTER);
    text("Back", backButtonX + backButtonWidth / 2, backButtonY + backButtonHeight / 2);
  }
}

void mousePressed() {
  // Check if the mouse click is within any of the buttons' area
  if (onButtonScreen) {
    for (int i = 0; i < buttonColors.length; i++) {
      int buttonX = startX + (i % 5) * (buttonWidth + buttonSpacing);
      int buttonY = startY + (i / 5) * (buttonHeight + buttonSpacing);
      
      if (mouseX > buttonX && mouseX < buttonX + buttonWidth &&
          mouseY > buttonY && mouseY < buttonY + buttonHeight) {
        // Change the background color to the button's color
        background(buttonColors[i]);
        onButtonScreen = false; // Switch to background screen
        break;
      }
    }
  }
  
  // Check if the "Back" button is pressed
  if (mouseX > backButtonX && mouseX < backButtonX + backButtonWidth &&
      mouseY > backButtonY && mouseY < backButtonY + backButtonHeight) {
    onButtonScreen = true; // Go back to the button screen
    background(200); // Set a neutral background color
  }
}
