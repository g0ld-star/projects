class Enemy {
  float x, y, speedX, speedY;

  Enemy() {
    // Spawn enemies at the edges of the screen randomly
   int spawnSide = int(random(4)); // 0 = left, 1 = top, 2 = right, 3 = bottom
   
    if (spawnSide == 0) { // Left (spawn at x = 0, random y)
      x = 0;
      y = random(height);
      speedX = 2;  // Moving right
      speedY = random(-2, 2);  // Random vertical speed
    } 
    
    else if (spawnSide == 1) { // Top (spawn at y = 0, random x)
      x = random(width);
      y = 0;
      speedX = random(-2, 2);  // Random horizontal speed
      speedY = 2;  // Moving down
    } 
    
    else if (spawnSide == 2) { // Right (spawn at x = width, random y)
      x = width;
      y = random(height);
      speedX = -2;  // Moving left
      speedY = random(-2, 2);  // Random vertical speed
    } 
    
    else { // Bottom (spawn at y = height, random x)
      x = random(width);
      y = height;
      speedX = random(-2, 2);  // Random horizontal speed
      speedY = -2;  // Moving up
    }
  }

  void update() {
    x += speedX;
    y += speedY;
    
    // Check if the enemy is off-screen and reset position if needed
    if (x < 0 || x > width || y < 0 || y > height) {
      x = random(width);
      y = random(height);
    }
  }

  void display() {
    fill(255, 0, 0);  // Red color for enemies
    noStroke();
    ellipse(x, y, 20, 20);  // Draw the enemy as a circle
  }
}
