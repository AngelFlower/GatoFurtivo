//Módulo PantLoad
//Elaborado por: Padilla Mancilla Alfredo
//Fecha de creación: 18 de septiembre de 2023 
//Fecha de última modificacion: 25 de octubre de 2023
//Descripción: El módulo PantLoad controla la pantalla
// de carga inicial de datos del juego.

class PantLoad{
  Temporizador tmpidle;
  boolean loading;
  int msg;
  int red,green,blue;
  
  PantLoad(){
    tmpidle=new Temporizador(18);
    loading=true;
    red=(int)random(0,255);
    green=(int)random(0,255);
    blue=(int)random(0,255);
  }
  
  void display(){
    // change color every frame. Smoothly. No random.
    if(loading){
      // randoum increment only 2 colors per frame
      red+=random(-1,Integer.signum((int)random(-1,1)));
      green+=random(-1,Integer.signum((int)random(-1,1)));
      blue+=random(-1,Integer.signum((int)random(-1,1)));

      if(red<10) red=(int)random(0,200);
      if(green<10) green=(int)random(0,200);
      if(blue<10) blue=(int)random(0,200);

      // constrain color values
      red=constrain(red,0,255);
      green=constrain(green,0,255);
      blue=constrain(blue,0,255);
      
    }
    background(red,green,blue);
    fill(255);
    stroke(255);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(1),640,360);
    text(idi.getMensaje(msg),400,600);
    if(!loading && !tmpidle.isActive())
      tmpidle.activate();
    if(tmpidle.isActive())
      tmpidle.coolingDown();
    if(tmpidle.isOff())
      gc.setPantAct(PANTPRIN);
  }
}
