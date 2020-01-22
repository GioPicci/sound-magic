import processing.sound.*;
class Onda {
  ArrayList<Impulso> impulsi;
  Sorgente source;
  
  float vx,vy,vz;
  float xrot,yrot,zrot;
  float frequenza;
  float coeff;
  double intensita;
  
  color fcolor;
  int time=0;
  
  Onda(float x, float y , float z, float f, Sorgente s, float xr, float yr, float zr,double intensity,float coeff) {
    vx=x;
    vy=y;
    vz=z;
    
    xrot=xr;
    yrot=yr;
    zrot=zr;
    
    frequenza=f/4;
    source=s;
    impulsi=new ArrayList<Impulso>();  
    fcolor=colorCode();
    intensita=intensity;
    this.coeff=coeff;
  }
  
  void create() {
    time++;
    if(time>=(4000/frequenza)) {
      if(impulsi.size()>200) impulsi.remove(0);
      impulsi.add(new Impulso(vx,vy,vz,source.getX()+1,source.getY()+1,source.getZ()+1,xrot,yrot,zrot,fcolor,intensita,coeff));
      time=0;
    }
  }
  
  void checkImpulse() {
    for(Impulso i : impulsi) {
      i.checkBorders();
    }
    for(int i=0; i<impulsi.size(); i++) {
      if(impulsi.get(i).checkEnergy()) {
        //T60=impulsi.get(i).getT60();
        impulsi.remove(i);
      }
    }
  }
  
 color colorCode() {
   if(frequenza<250) {
     fcolor=color(0,frequenza,250);
   }
   else if(frequenza<500) {
     fcolor=color(0,250,250-(frequenza-250));
   }
   else if(frequenza<750) {
     fcolor=color(frequenza-500,250,0);
   }
   else if(frequenza<=1000) {
     fcolor=color(250,250-(frequenza-750),0);
   }
   return fcolor;
 }
  
  void run(float f,float co) {
    coeff=co;
    frequenza=f/4;
    checkImpulse();
    for(int i=0;i<impulsi.size(); i++) {
          impulsi.get(i).run(colorCode());
    }
    create();
  }
 
}
