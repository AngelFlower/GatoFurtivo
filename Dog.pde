// Dog class
class Dog {
  PVector position;
  float speed;
  PImage[] dogSprites;  // Use an array for multiple images
  int currentFrame = 0; // Keep track of the current frame

  Dog(float x, float y, float speed) {
    position = new PVector(x, y);
    this.speed = speed;
    dogSprites = new PImage[5]; // Adjust the size based on the number of frames
    for (int i = 0; i < dogSprites.length; i++) {
      dogSprites[i] = loadImage("sprite/sprites/animation/dog/dog" + (i + 1) + ".png");
    }
  }

  void display() {
    // Display the current frame of the dog animation
    image(dogSprites[currentFrame], position.x, position.y, 100, 100);
  }

  void move() {
    // Move the dog horizontally
    position.x -= speed;

    // If the dog goes off the screen, reset its position
    if (position.x < -40) {
      position.x = width;
    }

    // Update the animation frame
    currentFrame = (currentFrame + 1) % dogSprites.length;
  }

  void setPosition(float x, float y) {
    // Set the position of the dog
    if (x < 0) {
      position.x = x;
      position.y = y;
    }
  }
}
