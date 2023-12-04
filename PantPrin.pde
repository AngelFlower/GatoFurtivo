//Módulo PantPrin
//Elaborado por: Padilla Mancilla Alfredo
//Fecha de creación: 18 de septiembre de 2023 
//Fecha de última modificacion: 27 de noviembre de 2023
//Descripción: El módulo PantPrin controla la pantalla
// principal del juego.

class PantPrin{
  PImage imgtit;
  Boton btnplay;
  Boton btnexit;
  Boton btncred;
  Boton btntops;
  Boton btnconf;
  Boton btnInstructions;
  Temporizador tmpexit;
  
  PantPrin(){
    imgtit=loadImage("sprite/fondos/fododegatomain.jpg");
    btnInstructions=new Boton(990,350,cf.btnw,cf.btnh,38);
    btnconf=new Boton(990,410,cf.btnw,cf.btnh,10);
    btnplay=new Boton(990,470,cf.btnw + 12 ,cf.btnh + 12,11);
    btntops=new Boton(990,530,cf.btnw,cf.btnh,12);
    btncred=new Boton(990,590,cf.btnw,cf.btnh,13);
    btnexit=new Boton(990,650,cf.btnw,cf.btnh,14);
    tmpexit=new Temporizador(120);
  }
  
  void display(){
    music();
    background(255);
    fill(0);
    stroke(0);
    textAlign(CENTER,CENTER);
    imageMode(CENTER);
    image(imgtit,640,360);
    textSize(45);
    text("Gato Furtivo",640,100);
    fill(255);
    text("Gato Furtivo",642,102);
    textSize(20);
    btnInstructions.display();
    btnconf.display();
    btnplay.display();
    btntops.display();
    btncred.display();
    btnexit.display();
    if(tmpexit.isActive())
      tmpexit.coolingDown();
    if(tmpexit.isOff()){
      bit.cierraBitacora();
      exit();
    }  
  }
  
  void mouseControl(int x,int y,int b){
    if(btnInstructions.isClicked(x,y,b)){
      gc.setPantAct(SCREENINSTRUCTIONS);
    }
    if(btnconf.isClicked(x,y,b)){ 
      gc.setPantAct(PANTCONF);
    }  
    if(btnplay.isClicked(x,y,b)){
      voistart.trigger();
      gc.musicManager(false);
      gc.setPantAct(PANTGAME);
    }  
    if(btntops.isClicked(x,y,b))
      gc.setPantAct(PANTTOPS);
    if(btncred.isClicked(x,y,b)){
      gc.musicManager(false);
      gc.setPantAct(PANTCRED);
    }  
    if(btnexit.isClicked(x,y,b))
      tmpexit.activate();  
  }
}
