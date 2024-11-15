PImage dinobg;
int dinoX = 50; // X position of the dinosaur
int dinoY = 300; // Y position of the dinosaur
int dinoWidth = 40; // Width of the dinosaur
int dinoHeight = 40; // Height of the dinosaur

int groundY = 0; // Y position of the ground
int groundY2=350;
boolean isJumping = false; // If the dinosaur is jumping
int jumpSpeed = 15; // The speed at which the dino jumps
int jumpHeight = 100; // Maximum jump height
int jumpCounter = 0; // Counter to track the jump height

ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>(); // List of obstacles

// Background variables
int backgroundX1 = 0; // X position of the first background
int backgroundX2 = width; // X position of the second background
int backgroundSpeed = 3; // Speed at which the background moves

void setup() {
  size(800, 600); // Set window size
  frameRate(60); // Set the frame rate
  dinobg= loadImage ("mixedcolorbg.png");
}

void draw() {
  background(255); // Set background color
  
  // Draw the moving background
  moveBackground();
  
  // Handle jumping logic
  if (isJumping) {
    if (jumpCounter < jumpHeight) {
      dinoY -= jumpSpeed;
      jumpCounter++;
    } else {
      isJumping = false;
    }
  } else if (dinoY < groundY - dinoHeight) {
    dinoY += jumpSpeed;
    jumpCounter--;
  }
  
  // Draw the dinosaur
  fill(255, 0, 0); // Red color for the dinosaur
  rect(dinoX, dinoY, dinoWidth, dinoHeight);
  
  // Update obstacles and draw them
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Obstacle obs = obstacles.get(i);
    obs.update();
    obs.display();
    
    // Check for collision
    if (obs.collides(dinoX, dinoY, dinoWidth, dinoHeight)) {
      noLoop(); // Stop the game if there's a collision
      textSize(50);
      fill(0);
      textAlign(CENTER, CENTER);
      text("GAME OVER!", width / 2, height / 2);
    }
    
    // Remove obstacles that go off screen
    if (obs.x + obs.width < 0) {
      obstacles.remove(i);
    }
  }
  
  // Spawn new obstacles
  if (frameCount % 60 == 0) {
    obstacles.add(new Obstacle(width, groundY - 40, 20, 40));
  }
}

void keyPressed() {
  if (key == ' ' && !isJumping) {
    isJumping = true;
    jumpCounter = 0; // Reset jump counter
  }
}

void moveBackground() {
  // Move both parts of the background
  backgroundX1 -= backgroundSpeed;
  backgroundX2 -= backgroundSpeed;
  
  // If the background goes off screen, reset it
  if (backgroundX1 < -width) {
    backgroundX1 = width;
  }
  if (backgroundX2 < -width) {
    backgroundX2 = width;
  }
  
  // Draw the two background images (or rectangles if no image)
 fill(135, 206, 235); // Sky blue color
  //rect(backgroundX1, width, groundY);
  image (dinobg, backgroundX1, groundY);
  rect(backgroundX2, 0, width, groundY);
  //image(dinobg,backgroundX1, groundY);
    //image(dinobg,backgroundX2, groundY);
  
  // Optionally, you can add a ground layer that moves too
  //fill(0, 200, 0); // Green color for the ground
//  rect(backgroundX1, groundY, width, height - groundY);
rect(backgroundX2, groundY2, width, height - groundY2);
}

class Obstacle {
  int x, y, width, height;
  int speed = 5;
  
  Obstacle(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  // Update the position of the obstacle
  void update() {
    x -= speed;
  }
  
  // Display the obstacle
  void display() {
    fill(0); // Black color for the obstacle
    rect(x, y, width, height);
  }
  
  // Check if the obstacle collides with the dinosaur
  boolean collides(int dinoX, int dinoY, int dinoWidth, int dinoHeight) {
    return (x < dinoX + dinoWidth && x + width > dinoX && y < dinoY + dinoHeight && y + height > dinoY);
  }
}
