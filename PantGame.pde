//Módulo PantGame
//Elaborado por: Padilla Mancilla Alfredo
//Fecha de creación: 23 de septiembre de 2023 
//Fecha de última modificacion: 2 de diciembre de 2023
//Descripción: El módulo PantGame controla la pantalla
// de "acción" del juego.

class PantGame{
  Personaje per;
  HealItem hi;
  Reloj rlj;
  PImage cielo;
  PImage montes;
  PImage piso;
  Punto2D imgcie;
  Punto2D imgmon;
  Punto2D imgpis;
  Boton btnpause;
  Enemigo enemy;
  Dog dog;
  Dog dog2;
  Dog dog3;
  Dog dog4;
  float bal;
  int dir;
  
  PantGame(){
    per=new Personaje(140,500,100,200);
    hi=new HealItem(450,500,0,0);
    rlj=new Reloj();
    rlj.iniciaReloj();
    cielo=loadImage("sprite/fondos/cielo.png");
    montes=loadImage("sprite/fondos/montes.png");
    piso=loadImage("sprite/fondos/piso.png");
    imgcie=new Punto2D(0,0);
    imgmon=new Punto2D(0,-65);
    imgpis=new Punto2D(0,260);
    enemy=new Enemigo(cf.estartx,cf.estarty,100,200);
    dog = new Dog(width, height / 2, random(10, 30));
    dog2 = new Dog(width, (float) random(0, height), random(10, 20));
    dog3 = new Dog(width, (float) random(0, height), random(10, 30));
    // dog4 = new Dog(width, (float) random(0, height), random(10, 40));
    btnpause=new Boton(0,985,cf.btnw,cf.btnh,15);
    bal=-1.0;
    dir=RIGHT;
  }
  
  void display(){
    music();
    if(resetgame)
      resetGame();
    background(0);
    fill(255);
    stroke(255);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(0),640,360);
    planoCielo();
    planoFondo();
    planoFrente();
    moverPlanos();
    imageMode(CENTER);
    hi.display();
    graficaCombatientes();
    enemy.setPerpos(per.pos);
    dog.display();
    dog.setPosition(random(0, width), random(160, height));
    dog.move();
    dog2.display();
    dog2.setPosition(random(0, width), random(160, height));
    dog2.move();
    dog3.display();
    dog3.setPosition(random(0, width), random(160, height));
    dog3.move();
    // dog4.display();
    // dog4.position(random(0, width), random(100, height));
    // dog4.move();
    checkColisiones();
    rlj.controlReloj();
    btnpause.display();
    bal+=(dir==RIGHT)?0.001:-0.001;
    if(Math.abs(bal)>=1)
      dir=(bal>=1)?LEFT:RIGHT;
    mscstage.setBalance(bal);  
    if(per.isDead() && per.anistr.getActiveSpriteSet().endot){
      rlj.detenReloj();
      salvaTiempo();
      gc.pantendgame.cargaFinal(false);
      win=false;
      gc.musicManager(false);
      gc.setPantAct(PANTENDG);
    }  
  }
  
  void graficaCombatientes(){
    if(per.pos.getY()<=enemy.pos.getY()){ //personaje al fondo
      per.display();
      enemy.display(per.getOnScroll(),per.getOnMotion());
    }
    else{  //enemigo al fondo
      enemy.display(per.getOnScroll(),per.getOnMotion());
      per.display();
    }
  }
  
  void planoCielo(){
    imageMode(CORNER);
    image(cielo,imgcie.getX(),imgcie.getY());
  }
  
  void planoFondo(){
    imageMode(CORNER);
    image(montes,imgmon.getX(),imgmon.getY());
  }
  
  void planoFrente(){
    imageMode(CORNER);
    image(piso,imgpis.getX(),imgpis.getY());
    rlj.display(640,50);
  }
  
  void moverPlanos(){
    if(imgcie.getX()<=-2560)
      per.reachedBorder();
    if(per.hasMovedX()&& imgcie.getX()>-2560){
      // imgcie.moverP(-1,0);
      // imgmon.moverP(-2,0);
      // imgpis.moverP(-3,0);
      // hi.moverH(-3,0);
      imgcie.moverP(-3,0);
      imgmon.moverP(-6,0);
      imgpis.moverP(-9,0);
      hi.moverH(-9,0);
    }
  }
  
  void keyControl(char k){
    per.keyControl(k);
  }
  
  void keyRelControl(char k){
    per.keyRelControl(k);
  }
  
  void mouseControl(int x,int y,int b){
    if(btnpause.isClicked(x,y,b)){
      mscstage.setGain(cf.mscgainlow);
      gc.setPantAct(PANTPAUS);
    }  
  }
  
  void checkColisiones(){
    //colisiones del cuerpo del personaje contra otros elementos
    if(per.clbody.isColision(enemy.clbody))
      per.undoMotion();  
    if(per.clbody.isColision(hi.clheal)){
      sfxdrink.trigger();
      per.curar(); 
      per.ht.activate();
      per.clbody.deactivate();
      hi.toggleActive();
    }
    //colisiones de combate del personaje contra el cuerpo del enemigo
    if(per.clkick.isColision(enemy.clbody)){
      if(enemy.herir(DMGK)){
        rlj.detenReloj();
        salvaTiempo();
      }
      per.clkick.active=false;
      per.onhit=true;
    }  
    if(per.clpnch.isColision(enemy.clbody)||per.clpnch.isColision(enemy.clhead)){
      if(enemy.herir(DMGP)){
        rlj.detenReloj();
        salvaTiempo();
      }
      per.clpnch.active=false;
      per.onhit=true;
    }  
    if(per.clkick.isColision(enemy.clbody)||per.clkick.isColision(enemy.clhead)){
      if(enemy.herir(DMGK)){
        rlj.detenReloj();
        salvaTiempo();
      }
      per.clkick.active=false;
      per.onhit=true;
    }  
    //colisión de "ver" del enemigo
    if(enemy.clview.isColision(per.clhead)){
      voiseeu.trigger();
      enemy.clview.active=false;
      enemy.setConducta(CNDATK);
    }
    //colisiones del cuerpo del enemigo contra otros elementos
    if(enemy.clbody.isColision(per.clbody))
      enemy.undoMotion();
    if(enemy.clview.isColision(per.clbody))
      enemy.setConducta(CNDATK);
    //colisiones de combate del enemigo contra el cuerpo del personaje
    if(enemy.clkick.isColision(per.clbody)||enemy.clkick.isColision(per.clhead)){
      if(per.herir(DMGK)){
        rlj.detenReloj();
        salvaTiempo();
      }
      enemy.clkick.active=false;
      enemy.onhit=true;
    }  
    if(enemy.clpnch.isColision(per.clbody)||enemy.clpnch.isColision(per.clhead)){
      if(per.herir(DMGP)){
        rlj.detenReloj();
        salvaTiempo();
      }
      enemy.clpnch.active=false;
      enemy.onhit=true;
    }  
  }
  
  void resetGame(){
    per=new Personaje(140,500,100,200);
    hi=new HealItem(450,500,0,0);
    rlj.resetReloj();
    rlj.iniciaReloj();
    enemy=new Enemigo(cf.estartx,cf.estarty,100,200);
    imgcie=new Punto2D(0,0);
    imgmon=new Punto2D(0,-70);
    imgpis=new Punto2D(0,260);
    bal=-1.0;
    dir=RIGHT;
    resetgame=false;
  }
  
  void salvaTiempo(){
    String td=""+rlj.getTime();
    ts.addTime(td);
    ts.saveData();
  }
}
