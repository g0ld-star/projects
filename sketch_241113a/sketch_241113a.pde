int itemX, itemY; // Position of the item
int itemRadius = 30;
ArrayList<Line> drawnLines; // List to store the lines drawn by the player
ArrayList<Enemy> enemies; // List to store the enemies
boolean gameOver = false;

void setup() {
  size(800, 600);
  itemX = width / 2;
  itemY = height / 2;
  drawnLines = new ArrayList<Line>();
  enemies = new ArrayList<Enemy>();
  for (int i = 0; i < 5; i++) {
    enemies.add(new Enemy());
  }
  strokeWeight(5);
}

void draw() {
  background(255,192,203); // White background
  
  if (!gameOver) {
    // Draw item
    fill(0, 255, 0);
    ellipse(itemX, itemY, itemRadius * 2, itemRadius * 2);

    // Draw drawn lines
    stroke(255, 0, 0);
    for (Line line : drawnLines) {
      line.display();
    }

    // Update and draw enemies
    for (Enemy e : enemies) {
      e.update();
      e.display();
      if (e.collidesWithItem(itemX, itemY, itemRadius)) {
        gameOver = true;
        textSize(32);
        fill(0);
        text("Game Over!", width / 2 - 100, height / 2);
      }
    }

    // Check if enemies attack the lines
    for (Enemy e : enemies) {
      if (e.collidesWithLine(drawnLines)) {
        gameOver = true;
        textSize(32);
        fill(0);
        text("Game Over! Line Broken!", width / 2 - 180, height / 2);
      }
    }
  }
}

void mousePressed() {
  //if (!gameOver) {
    drawnLines.add(new Line(mouseX, mouseY, mouseX, mouseY));
  //}
}

void mouseDragged() {
  if (!gameOver && drawnLines.size() > 0) {
    Line currentLine = drawnLines.get(drawnLines.size() - 1);
    currentLine.update(mouseX, mouseY);
  }
}

// Line class to store the start and end points of the lines
class Line {
  float x1, y1, x2, y2;
  
  Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  void update(float x2, float y2) {
    this.x2 = x2;
    this.y2 = y2;
  }

  void display() {
    line(x1, y1, x2, y2);
  }
}

// Enemy class to handle enemy behavior
class Enemy {
  float x, y;
  float speed = 1;
  float radius = 20;
  boolean isMoving = true;
  
  Enemy() {
    x =0;
    y = 0;
  }

  void update() {
    if (isMoving) {
      float dx = itemX - x;
      float dy = itemY - y;
      float dist = sqrt(dx * dx + dy * dy);
      if (dist > 2) {
        x += dx / dist * speed;
        y += dy / dist * speed;
      }
    }
  }

  void display() {
    fill(0, 0, 255);
    ellipse(x, y, radius * 2, radius * 2);
  }

  boolean collidesWithItem(int itemX, int itemY, int itemRadius) {
    float dist = sqrt(pow(itemX - x, 2) + pow(itemY - y, 2));
    return dist < itemRadius + radius;
  }

  boolean collidesWithLine(ArrayList<Line> lines) {
    for (Line line : lines) {
      float distance = distToLineSegment(x, y, line.x1, line.y1, line.x2, line.y2);
      if (distance < radius) {
        return true;
      }
    }
    return false;
  }

  // Helper function to compute distance from a point to a line segment
  float distToLineSegment(float px, float py, float x1, float y1, float x2, float y2) {
    float lineLength = dist(x1, y1, x2, y2);
    float dotProduct = ((px - x1) * (x2 - x1) + (py - y1) * (y2 - y1)) / lineLength;
    float closestX = x1 + dotProduct * (x2 - x1) / lineLength;
    float closestY = y1 + dotProduct * (y2 - y1) / lineLength;
    return dist(px, py, closestX, closestY);
  }
}
