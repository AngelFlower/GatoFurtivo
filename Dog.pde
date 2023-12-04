// Dog class
class Dog {
  PVector position;
  float speed;

  Dog(float x, float y, float speed) {
    position = new PVector(x, y);
    this.speed = speed;
  }

  void display() {
    // Display the enemy
    fill(255, 0, 0);
    ellipse(position.x, position.y, 20, 20);
  }

  void move() {
    // Move the enemy horizontally
    position.x -= speed;
    
    // If the enemy goes off the screen, reset its position
    if (position.x < 0) {
      position.x = width;
    }
  }

  void position(float x, float y) {
    if (x < 10) {
      position.x = x;
      position.y = y;
    }
  }
}

