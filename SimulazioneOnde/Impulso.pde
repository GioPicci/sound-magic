class Impulso {
  boolean verse=false;
  float vx,vy,vz;
  float curve;
  float posx,posy,posz;
  float xrot,yrot,zrot;
  
  float ix,iy,iz;
  float time=1;
  
  double intensita,intIniziale;
  float decibel,decIniziale;
  float coeff;
  
  color c;
  
  Impulso(float vx,float vy, float vz, float px, float py, float pz,float xr ,float yr, float zr,color fcolor,double intensity,float coeff) {
    this.vx=vx;
    this.vy=vy;
    this.vz=vz;
    
    posx=px;
    posy=py;
    posz=pz;
    
    ix=0.05;
    iy=0.05;
    iz=0.05;
    
    xrot=xr;
    yrot=yr;
    zrot=zr;
    c=fcolor;
    curve=10;
    
    intensita=intensity;
    intIniziale=intensity;
    decIniziale=20*(log((float)(intIniziale/0.00002))/log(10) );
    decibel=decIniziale;
    this.coeff=coeff;
  }
  
  void create() {
    noFill();
    stroke(c);
    strokeWeight(3);
    pushMatrix();
      translate(posx,posy,posz);
      rotateX(xrot);
      rotateY(yrot);
      rotateZ(zrot);
      bezier(-curve,-curve-iy,0,+ix,-(curve/10*3),0,+ix,+(curve/10*3),0,-curve,+curve+iy,0);
    popMatrix();
    if(verse==false) {
      if(ix<10)
        ix+=0.04;
      if(iy<40)
        iy+=0.2;
    }
    else {
      if(ix>-10)
        ix-=0.04;
      if(iy>-40)
        iy-=0.2;
    }
  } 
  
  void move() {
    posx+=vx;
    posy+=vy;
    posz+=vz;
  }
  
  void energy() {
    time++;
    //intensita=intIniziale/(pow(time/25.0,2));
    intensita=intIniziale/(4*PI*pow((time/100.0),2));
    decibel=20*(log((float)(intensita/0.00002))/log(10) );
    c=color(red(c),green(c),blue(c),255-((decIniziale-decibel)*4.25));
  }
  
  void checkBorders() {
    if(posx>200 || posx<-200) {
      curve=-curve;
      vx=-vx;
      verse=!verse;
      ix=0;
      iy=0;
      yrot=-yrot;
      zrot=-zrot;
      //xrot=-xrot;
      absorbEnergy();
    }
    
    if(posy>200 || posy<-200) {
      //curve=-curve;
      vy=-vy;
      //verse=!verse;
      ix=0;
      iy=0;
      //yrot=-yrot;
      zrot=-zrot;
      xrot=-xrot;
      absorbEnergy();
    }
    
    if(posz>200 || posz<-200) {
      //curve=-curve;
      vz=-vz;
      //verse=!verse;
      ix=0;
      iy=0;
      yrot=-yrot;
      //zrot=-zrot;
      xrot=-xrot;
    }
  }
  
  boolean checkEnergy() {
    if(decIniziale-decibel>=60) return true;
    return false;
  }
  
/*  float getT60() { NON FUNZIONA!
    return time/60.0;
  }*/
  void absorbEnergy() {
    intIniziale=intIniziale-(intIniziale*coeff);
  }
  
  void run(color c) {
      this.c=c;
      energy();
      create();
      move();
  }
}
