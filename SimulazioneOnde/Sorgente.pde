class Sorgente {
  float posX,posY,posZ;
  
  Sorgente(float x, float y, float z) {
    posX=x;
    posY=y;
    posZ=z;
  }
  
  void create() {
    pushMatrix();
      translate(posX,posY,posZ);
      stroke(0);
      sphere(10);
    popMatrix();
  }
  
  float getX() { return posX; }
  float getY() { return posY; }
  float getZ() { return posZ; }
  
  void setX(float px){
    posX=px;
  }
  
  void setY(float py){
    posY=py;
  }
  
  void setZ(float pz) {
    posZ=pz;
  }
}
