class Shoter {
  PVector loc;
  PVector mouse;
  PVector dif;    
  PVector vel;    
  Shoter () {   
    loc=new PVector();
    dif=new PVector();     
  }
  void displayUpdate() {
    mouse = new PVector(mouseX, mouseY);
    dif=PVector.sub(mouse, loc);      
    loc.add(PVector.mult(dif, 0.1));
    dif.normalize();
    dif.mult(16);
    noStroke();
    fill(190,25);
    ellipse(mouseX, mouseY, 18, 18);
    fill(40, 255, 160, 80);
    ellipse(loc.x, loc.y, 30, 30); 
    
  }  
}