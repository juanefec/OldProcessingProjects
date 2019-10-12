class Shot {
  PVector loc;
  PVector vel;  
  int r, g, b;
  boolean hit=false; 
  Shot (PVector loc, PVector direction, int r, int g, int b) {    
    this.loc = loc.get();
    vel= direction.get();
    vel.normalize();
    vel.mult(14.8);
    this.r=r;
    this.g=g;
    this.b=b;
  }
  void displayShot() {    
    loc.add(vel);
    noStroke();
    fill(r, g, b);
    ellipse(loc.x, loc.y, 4, 4);
  }
}