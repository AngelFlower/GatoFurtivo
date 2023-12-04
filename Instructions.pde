

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
        text(idi.getMensaje(3),640,360);
        imageMode(CENTER);
        image(imgtit,640,360);
        btnback.display();
    }
    
    void mouseControl(int x,int y,int b){
        if(btnback.isClicked(x,y,b)){
        gc.musicManager(true);
        gc.setPantAct(PANTPRIN);
        }  
    }
}