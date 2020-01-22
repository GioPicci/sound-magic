class Suono {
  ArrayList<Onda> waves;
  Sorgente source;
  float sx,sy,sz;
  float frequenza;
  float T60;
  float coeff;
  double intensita;
  
  Suono(Sorgente s, float freq,double intens,float coeff) {
    source=s;
    frequenza=freq;
    intensita=intens;
    this.coeff=coeff;
    
    sx=source.getX();
    sy=source.getY();
    sz=source.getZ();
    waves=new ArrayList<Onda>();
    
    waves.add(new Onda(1,0,0,frequenza,source,0,0,0,intensita,coeff));
    waves.add(new Onda(-1,0,0,frequenza,source,0,PI,0,intensita,coeff));
    waves.add(new Onda(0,1,0,frequenza,source,0,0,PI/2,intensita,coeff));
    waves.add(new Onda(0,-1,0,frequenza,source,0,0,-PI/2,intensita,coeff));
    waves.add(new Onda(0,0,1,frequenza,source,0,-PI/2,0,intensita,coeff));
    waves.add(new Onda(0,0,-1,frequenza,source,0,PI/2,0,intensita,coeff));
    
    waves.add(new Onda(1,1,0,frequenza,source,0,0,PI/4,intensita,coeff));
    waves.add(new Onda(-1,1,0,frequenza,source,0,0,(PI/4)*3,intensita,coeff));
    waves.add(new Onda(0,1,1,frequenza,source,PI/4,0,PI/2,intensita,coeff));
    waves.add(new Onda(0,-1,1,frequenza,source,-PI/4,0,-PI/2,intensita,coeff));
    waves.add(new Onda(1,0,1,frequenza,source,0,-PI/4,0,intensita,coeff));
    waves.add(new Onda(1,0,-1,frequenza,source,0,PI/4,0,intensita,coeff));
    
    waves.add(new Onda(-1,-1,0,frequenza,source,0,0,-3*(PI/4),intensita,coeff));
    waves.add(new Onda(1,-1,0,frequenza,source,0,0,-(PI/4),intensita,coeff));
    waves.add(new Onda(0,-1,-1,frequenza,source,-3*(PI/4),0,PI/2,intensita,coeff));
    waves.add(new Onda(0,1,-1,frequenza,source,3*(PI/4),0,-PI/2,intensita,coeff));
    waves.add(new Onda(-1,0,-1,frequenza,source,0,3*(PI/4),0,intensita,coeff));
    waves.add(new Onda(-1,0,1,frequenza,source,0,-3*(PI/4),0,intensita,coeff));
  }
  
  void generate(float f,float co) {
    //T60=0;
    for(Onda o: waves) {
      o.run(f,co);
      //T60+=o.getT60();
    }
  }
  
/*  float getT60() { NON FUNZIONA!
    return T60/16;
  }*/
  
/*  void check() {
    for(Onda o:waves) {
      o.checkBorders();
    }
  } */
}
