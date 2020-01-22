boolean start=false;   //TEST INIZIATO O NO

float Yrotation=0.0;
float Xrotation=0.0;
float zoom=0.0;        //VARIABILI POSIZIONE STANZA
float frequency=10;
float thickness=2.5;

PImage floor;
ArrayList<PImage> walls;
PImage background;
//PImage tex_alpha;         //VARIABILI APPEARANCE STANZA
color col=color(201,173,83);

float [][] coeffs= { {0.10,0.30,0.60,0.70,0.80,0.85 },  //POSSIBILI COEFFICIENTI DI
                    {0.20,0.65,0.90,0.85,0.80,0.85 },  //ASSORBIMENTO
                    {0.60,0.95,0.95,0.85,0.80,0.90 },
                    {0.10,0.30,0.70,0.80,0.80,0.85 },
                    {0.20,0.65,0.95,0.90,0.85,0.90 },
                    {0.07,0.20,0.40,0.55,0.70,0.70 },
                    {0.04,0.05,0.06,0.14,0.30,0.25 }, };  

int alpha;
int selected=0;
int index=0;
int frange;

float coeff=coeffs[index][0];

//SinOsc sine;  //GENERATORE DI ONDE SINUSOIDALI

Stanza room;  //STANZA
Sorgente source;  //SORGENTE SONORA
Suono sound;  //SUONO
void setup() {
  
  size(1024,1024,P3D);
  
  walls=new ArrayList<PImage>();
  walls.add(loadImage("lana_di_roccia_rivestimento.jpg"));
  walls.add(loadImage("lana_di_vetro_rivestimento.jpg"));
  walls.add(loadImage("poliuretano_espanso_rivestimento.jpg"));
  walls.add(loadImage("polistirolo_espanso.jpg"));
  walls.add(loadImage("texture_muro_bianco.jpg"));
    
  floor=loadImage("ftexture_woodtiles.jpg");  
  
  background=loadImage("background_prato.jpg");
  
  //sine=new SinOsc(this);
  //sine.freq(frequency);
  
  room=new Stanza(floor,walls,selected,col,thickness); 
  source=new Sorgente(0,0,0);
  sound=new Suono(source,frequency,0.5,coeff);
  
}

void draw() {
  
  background(background);
  
  translate(500,550,100+zoom);
  rotateY(Yrotation);
  rotateX(Xrotation);
  
  source.create();
  room.create();
  if(start) {
    sound.generate(frequency,coeff);
  }
  
  frange=getFrequencyRange(frequency);
  coeff=getCoefficient(coeffs,index,frange);
  
  fill(255);
  pushMatrix();
    translate(0,0,200);
    text("Frequenza: "+nfs(frequency,1,0)+" Hz;",-300,-260);
    text("Spessore pareti: "+nfs(thickness,1,1)+" cm",-160,-260);
    text("Percentuale di assorbimento: "+nfs(coeff*100,1,0)+"%",0,-260);
    switch(selected) {
      case 0:
        text("MATERIALE: Lana di roccia",-300,-235);
      break;
      case 1:
        text("MATERIALE: Lana di vetro",-300,-235);
      break;
      case 2:
        text("MATERIALE: Poliuretano espanso",-300,-235);
      break;
      case 3:
        text("MATERIALE: Polistirolo espanso",-300,-235);
      break;
    }
    //text("T60= "+nfs(sound.getT60(),1,1)+" sec",0,-275); NON FUNZIONA!VELOCITA' SUONO NON ACCURATA
    text("Usa W,A,S,D per muovere la sorgente sonora lungo X e Y,E e Q per muoverla lungo Z e ",-250,-325);  //PARTE DI TESTO
    text("usa le frecce direzionali per ruotare la stanza.Usa 1,2,3,4 per scegliere le pareti e usa",-250,-310);
    text("'c' per modificarne lo spessore(se possibile).",-250,-295);
    fill(239,255,0);
    text("ENTER : avvia simulazione R: resetta stanza",70,-285);
  popMatrix();
 
  if(keyPressed) {
    if (keyCode==RIGHT) {
      Yrotation+=0.01;
    }
    if(keyCode==LEFT) {
      Yrotation-=0.01;
    }                     //ANGOLAZIONE STANZA
    if(keyCode==UP) {
      Xrotation+=0.01;
    }
    if(keyCode==DOWN) {
      Xrotation-=0.01;
    }
    
    if(key=='e') {
      source.setZ(constrain(source.getZ()-3,-185,185));
    }                    //SPOSTA SORGENTE LUNGO Z
    if(key=='q') {
      source.setZ(constrain(source.getZ()+3,-185,185));
    }
    
    if(key=='w') {
      source.setY(constrain(source.getY()-3,-185,185));
    }                   
    if(key=='a') {
      source.setX(constrain(source.getX()-3,-185,185));
    }                                                   //SPOSTA SORGENTE LUNGO X E Y
    if(key=='s') {
      source.setY(constrain(source.getY()+3,-185,185));
    }                    
    if(key=='d') {
      source.setX(constrain(source.getX()+3,-185,185));
    }
    
    /*if(key=='+') {
      zoom+=5;
    }                   //ZOOM SULLA STANZA(DA OTTIMIZZARE)
    if(key=='-') {
      zoom-=5;
    }*/
    
    if(key=='+') {
      if(frequency<4000)
        frequency+=10;
      //sine.freq(frequency);
    }                              //GESTISCI FREQUENZA (10 a 4000)
    if(key=='-') {
      if(frequency>10)
        frequency-=10;
      //sine.freq(frequency);
    }
    
    if(keyCode==ENTER) {     //INIZIO TEST
      start=true;
      //sine.play();
      loop();
    }
    
    /*if(key=='p') {       //PAUSA TEST
      noLoop();
      sine.stop();
    } */ 
    
    if(key=='r') {     //RESTART TEST
      Xrotation=0;
      Yrotation=0;
      zoom=0;
      start=false;
      //sine.stop();
      setup();
    }
    
    if(key=='1') {  //LANA DI ROCCIA
      selected=0;
      col=color(185,168,102);
      index=0;
      //sine.stop();
    }
    if(key=='2') { //LANA DI VETRO
      selected=1;
      col=color(201,173,83);
      index=3;
      //sine.stop();
    }
    if(key=='3') { //POLIURETANO ESPANSO
      selected=2;
      col=color(5);
      index=5;
      //sine.stop();
    }
    if(key=='4') { //POLISTIROLO ESPANSO
      selected=3;
      col=color(225,223,218);
      index=6;
      //sine.stop();
    }
    
    if(key>'0' && key<'5') {
      resetThickness();
      setup();
    }
    
  }
}

void keyReleased() {
  if(key=='c') {
    switch(selected) {
      case 0:
        switch((int)thickness) {
          case 2 : thickness=5;
                   index=1;
            break;
          case 5 : thickness=10;
                   index=2;
            break;
          case 10 : thickness=2.5;
                    index=0;
        } 
      break;
       
      case 1:
        switch((int)thickness) {
          case 2 : thickness=5;
                   index=4;
            break;
          case 5 : thickness=2.5;
                   index=3;
            break;
          case 10 : thickness=2.5;
                    index=3;
        } 
      break;
      
      case 2:
        switch((int)thickness) {
          case 2 : thickness=2.5;
            break;
          case 5 : thickness=2.5;
            break;
          case 10 : thickness=2.5;
        } 
      break;
      
      case 3:
        switch((int)thickness) {
          case 2 : thickness=2.5;
            break;
          case 5 : thickness=2.5;
            break;
          case 10 : thickness=2.5;
        } 
      break;
    }
    setup();
  }
}

void resetThickness() {thickness=2.5; }

int getFrequencyRange(float freq) {
  int code=0;
  if( freq>200 && freq <=350 ) code=1;
  else if( freq>350 && freq<=750 ) code=2;
  else if( freq>750 && freq<=1750 ) code=3;
  else if( freq>1750 && freq<=3500 ) code=4;
  else if( freq>3500 ) code=5;
  
  return code;
}

float getCoefficient(float[][] coefs, int x, int y) {
  return coefs[x][y];
}
