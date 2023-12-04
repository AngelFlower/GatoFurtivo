// Dog class
class Dog {
  PVector position;
  int speed;
  PImage[] dogSprites;  // Use an array for multiple images
  int currentFrame = 0; // Keep track of the current frame
  Colisionador colisionador;
  Punto2D postion2d;

  Dog(int x, int y, int speed) {
    position = new PVector(x, y);
    postion2d=new Punto2D(x,y);
    this.speed = speed;
    dogSprites = new PImage[5]; // Adjust the size based on the number of frames
    for (int i = 0; i < dogSprites.length; i++) {
      dogSprites[i] = loadImage("sprite/sprites/animation/dog/dog" + (i + 1) + ".png");
    }
    colisionador=new Colisionador(postion2d,new Punto2D(cf.prpx,cf.prpy),30,COLATCK);
    colisionador.activate();
  }

  void display() {
    // Display the current frame of the dog animation
    image(dogSprites[currentFrame], position.x, position.y, 100, 100);
    colisionador.pos.setY((int) position.y+40);
  }

  void move() {
    // Move the dog horizontally
    position.x -= speed;
    // postion2d.setX(position.x);
    colisionador.pos.setX((int) position.x);    
    // If the dog goes off the screen, reset its position
    if (position.x < -60) {
      position.y = random(300, height);
      position.x = width;
      colisionador.pos.setX((int) position.x);
    }

    // Update the animation frame
    currentFrame = (currentFrame + 1) % dogSprites.length;
    if(cf.drwc){  
      colisionador.drawAreaColision();
    }
  }

  void setPosition(float x, float y) {
    // Set the position of the dog
    if (x < 1) {
      position.x = x;
      // position.y = random(0, height);
      colisionador.pos.setX((int) position.x);
      colisionador.pos.setY((int) position.y);
      speed = (int) random(15, 35);
    }
  }
}
