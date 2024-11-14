PImage flowergardenbg;
int map02Width = 2400; // Width of the long background
int map02Height = 600; // Height of the background (same as the window size)
float charX = 50; // Character's initial X position
float charY = 158; // Character's Y position
float charSpeed = 2; // Speed of the character

float cameraX = 0; // Camera's X position

void setup() {
size(800, 600); // Window size
flowergardenbg = loadImage("flowergardenbg.png");
}

void draw() {
// Background that is much longer than the screen
background(200, 200, 255);

// Scroll the long background based on camera position
imageMode(CORNER);
image(flowergardenbg, -cameraX, 0);

// Character
fill(255, 0, 0);
ellipse(charX, charY, 50, 50);

// Move the character with arrow keys
if (keyPressed) {
if (keyCode == RIGHT) {
charX += charSpeed;
} else if (keyCode == LEFT) {
charX -= charSpeed;
}
}

// Prevent the character from going off the left side of the screen
charX = constrain(charX, 25, map02Width - 25);

// Camera follows the character if it’s past the halfway point but not near the edge
if (charX > width / 2 && charX < map02Width - width / 2) {
cameraX = charX - width / 2; // Keep the camera centered on the character
}
// Near the right edge, allow the character to keep moving to the right
else if (charX >= map02Width - width / 2) {
cameraX = map02Width - width; // Stop the camera at the far right edge of the background
} else {
// If the character is within the left part of the screen, camera stays at the start
cameraX = 0;
}

// Draw the background again based on the adjusted camera position
image(flowergardenbg, -cameraX, 0);

// Draw the character at its position
fill(255, 0, 0);
ellipse(charX - cameraX, charY, 50, 50); // Adjust character position by camera offset
}
