int brushSize = 10;
color brushColor = color(0, 0, 0); // Default to black
boolean isDrawing = false;

void setup() {
  size(800, 600); // Set canvas size
  background(255); // White background
}

void draw() {
  if (isDrawing) {
    // Draw on canvas with the current brush color and size
    stroke(brushColor);
    strokeWeight(brushSize);
    line(mouseX, mouseY, pmouseX, pmouseY); // Draw a line from previous mouse position to the current
  }
}

void mousePressed() {
  // Start drawing when mouse is pressed
  isDrawing = true;
}

void mouseReleased() {
  // Stop drawing when mouse is released
  isDrawing = false;
}

void keyPressed() {
  // Clear the canvas when 'C' key is pressed
  if (key == 'C' || key == 'c') {
    background(255);
  }
  
  // Change brush color to red when 'R' key is pressed
  if (key == 'R' || key == 'r') {
    brushColor = color(255, 0, 0);
  }
  
  // Change brush color to green when 'G' key is pressed
  if (key == 'G' || key == 'g') {
    brushColor = color(0, 255, 0);
  }
  
  // Change brush color to blue when 'B' key is pressed
  if (key == 'B' || key == 'b') {
    brushColor = color(0, 0, 255);
  }
  
  // Increase brush size with '+' key
  if (key == '+') {
    brushSize += 1;
  }
  
  // Decrease brush size with '-' key
  if (key == '-') {
    brushSize = max(1, brushSize - 1); // Ensure brush size doesn't go below 1
  }
}
