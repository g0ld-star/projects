int characterX, characterY, characterRadius;
ArrayList<PVector> protectionb;
ArrayList<Enemy> enemies;
boolean isDrawingProtection = false;
boolean protectionActive = false;
boolean enemiesActive = false;
boolean isDrawing=false;
int protectionTime = 0; // Timer for the 3-second countdown
int gameState = 0; // 0 = waiting for protection, 1 = waiting for enemies, 2 = game over
int brushSize = 10;
int enemyHitsOnProtection = 0; // Counter for how many times an enemy hits the protection border
int maxHitsBeforeDisappear;
void setup() {
  size(800, 600);
  characterX = width / 2;
  characterY = height / 2;
  characterRadius = 30;
  protectionb = new ArrayList<PVector>();
  enemies = new ArrayList<Enemy>();
  strokeWeight(5);
  maxHitsBeforeDisappear = int(random(5, 15)); // Random value between 5 and 15
}

void draw() {
  if (isDrawing) {
    stroke(0, 0, 0);
    strokeWeight(5);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }

  // Draw the character
  fill(100, 200, 255);
  noStroke();
  ellipse(characterX, characterY, characterRadius * 2, characterRadius * 2);

  // Draw the protection shape if active
  if (protectionActive && protectionb.size() > 1) {
    stroke(0, 255, 0);
    noFill();
    beginShape();
    for (PVector pt : protectionb) {
      vertex(pt.x, pt.y);
    }
    endShape();
  }

  // Handle the game state
  if (gameState == 0) {
  } else if (gameState == 1) {
    // Waiting for enemies to attack (3-second countdown)
    protectionTime++;
    if (protectionTime > 180) {  // 180 frames = 3 seconds at 60 FPS
      enemiesActive = true;
      spawnEnemies(); // Spawn the enemies
      gameState = 2; // Change to game state where enemies start attacking
    }
  }

  // Handle the enemy movements and collisions
  if (gameState == 2 && enemiesActive) {
    // Update and display enemies
    for (Enemy e : enemies) {
      e.update();
      e.display();
    }

    // Check for collisions with protection shape
    for (Enemy e : enemies) {
      checkCollisionWithProtection(e);
    }
     if (enemyHitsOnProtection >= maxHitsBeforeDisappear) {
      protectionActive = false; // Disable protection after enough hits
      
    }
  }
}
void mousePressed() {
  isDrawing = true;
  stroke (0, 0, 0);
  strokeWeight(brushSize);
if (gameState == 0 && !protectionActive) {
  protectionb.clear();
  isDrawingProtection = true;
}
}
void mouseReleased() {
  if (isDrawingProtection) {
    protectionActive = true;
    isDrawingProtection = false;
    isDrawing = false;

    // Start the countdown for enemies after drawing the protection
    gameState = 1;
    protectionTime = 0; // Reset protection timer
    enemies.clear(); // Clear any existing enemies
  }
}

void mouseDragged() {
  if (isDrawingProtection) {
    protectionb.add(new PVector(mouseX, mouseY));
  }
}

// Function to check if an enemy collides with the protection path and bounces off
void checkCollisionWithProtection(Enemy e) {
  // Check if the enemy is inside the protection path (polygon)
  if (isInsideProtection(e.x, e.y)) {
    // Calculate the direction of the bounce
    PVector direction = new PVector(e.x - characterX, e.y - characterY);
    direction.normalize();

    // Reverse the enemy's velocity (bounce effect)
    e.speedX = -e.speedX;
    e.speedY = -e.speedY;

    // Move the enemy slightly away from the protection boundary
    e.x += direction.x * 2;
    e.y += direction.y * 2;
    enemyHitsOnProtection++;
  }
}

boolean isInsideProtection(float x, float y) {
  // Ray-casting algorithm to check if a point is inside a polygon (protection path)
  int count = 0;
  for (int i = 0; i < protectionb.size(); i++) {
    PVector p1 = protectionb.get(i);
    PVector p2 = protectionb.get((i + 1) % protectionb.size());
    if (y > min(p1.y, p2.y) && y <= max(p1.y, p2.y) && x <= max(p1.x, p2.x)) {
      float xinters = (y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y) + p1.x;
      if (p1.x == p2.x || x <= xinters) {
        count++;
      }
    }
  }
  return count % 2 != 0;  // Odd number of intersections means the point is inside
}

void spawnEnemies() {
  // Spawn enemies at the edges of the screen
  for (int i = 0; i < 5; i++) {
  
  }
}
