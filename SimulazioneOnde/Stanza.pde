class Stanza{
  PImage floor,wall,extWall;
  ArrayList<PImage> walls;
  color col;
  float size,thickness;
  int selected;
  
  Stanza(PImage f, ArrayList<PImage> walls,int selected,color c,float t) {;
    this.walls=new ArrayList<PImage>();
    this.walls=walls;
    
    size=200.0;
    thickness=t;
    col=c;    
    
    extWall=walls.get(walls.size()-1);
    wall=walls.get(selected);
    floor=f;
    
    extWall.resize((int)(size+thickness)*2+4,(int)size*2);
    wall.resize((int)size*2,(int)size*2);
    floor.resize((int)(size+thickness)*2,(int)(size+thickness)*2);
  }
  
  void create() {
    pushMatrix(); //FLOOR
      translate(-thickness,-thickness,-size-2);
      image(floor,-size,-size);
    popMatrix();
  
    pushMatrix(); //PARETE DX
      rotateY(PI/2);
      translate(0,0,size);
      image(wall,-size,-size);
      fill(col);
      noStroke();
      pushMatrix();
        translate(0,0,thickness/2+1);
        box(size*2,size*2+thickness*2+2,thickness);
        translate(0,-thickness-2,thickness/2+1);
        rotateZ(PI/2);
        image(extWall,-size,-size);
      popMatrix();
    popMatrix();
  
    pushMatrix();// PARETE SX
      rotateY(PI/2);
      translate(0,0,-size);
      image(wall,-size,-size);
      fill(col);
      noStroke();
      pushMatrix();
        translate(0,0,-thickness/2-1);
        box(size*2,(size*2)+(thickness*2)+2,thickness);
        translate(0,-thickness-2,-thickness/2-1);
        rotateZ(PI/2);
        image(extWall,-size,-size);
      popMatrix();
    popMatrix();
  
    pushMatrix();//MURO INF
      rotateX(PI/2);
      translate(0,0,-size);
      image(wall,-size,-size);
      fill(col);
      noStroke();
      pushMatrix();
        translate(0,0,-thickness/2-1);
        box(size*2,size*2+2,thickness);
        translate(-thickness-2,0,-thickness/2-1);
        image(extWall,-size,-size);
      popMatrix();
    popMatrix();
  
    pushMatrix(); //MURO SUP
      rotateX(PI/2);
      translate(0,0,size);
      image(wall,-size,-size);
      fill(col);
      noStroke();
      pushMatrix();
        translate(0,0,+thickness/2+1);
        box(size*2,size*2+1,thickness);
        translate(-thickness-2,0,+thickness/2+1);
        image(extWall,-size,-size);
      popMatrix();
    popMatrix();
  }
}
