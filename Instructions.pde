

class Instructions{
    PImage imgtit;
    Boton btnback;
    
    Instructions(){
        imgtit=loadImage("sprite/fondos/fododegatoinstructions.jpg");
        btnback=new Boton(990,650,cf.btnw,cf.btnh,14);
    }
    
    void display(){
        background(255);
        fill(0);
        stroke(0);
        textAlign(CENTER,CENTER);
        imageMode(CENTER);
        image(imgtit,640,360);
        textSize(30);
        text(idi.getMensaje(38),640,100);
        // fill white
        fill(255);
        text(idi.getMensaje(38),642,102);
        textSize(20);
        fill(0);
        text(idi.getMensaje(39),640,200);
        text(idi.getMensaje(40),640,240);
        text(idi.getMensaje(41),640,280);
        text(idi.getMensaje(42),640,320);
        text(idi.getMensaje(43),640,360);
        text(idi.getMensaje(44),640,400);
        text(idi.getMensaje(45),640,440);
        text(idi.getMensaje(46),640,480);
        fill(255);
        text(idi.getMensaje(39),642,202);
        text(idi.getMensaje(40),642,242);
        text(idi.getMensaje(41),642,282);
        text(idi.getMensaje(42),642,322);
        text(idi.getMensaje(43),642,362);
        text(idi.getMensaje(44),642,402);
        text(idi.getMensaje(45),642,442);
        text(idi.getMensaje(46),642,482);
        btnback.display();
    }
    
    void mouseControl(int x,int y,int b){
        if(btnback.isClicked(x,y,b)){
        gc.musicManager(true);
        gc.setPantAct(PANTPRIN);
        }  
    }
}