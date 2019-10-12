class MenuBackground {
  Particle [] particles; 
  Linker link;
  int i, j;
  int tam;
  MenuBackground() {
    tam=20;
    particles=new Particle[tam];
    for (int i=0; i<tam; i++) {        
      particles[i]=new Particle();
    }
    link=new Linker();
  }
  void run() {
    for (i=0; i<tam; i++) {      

      particles[i].displayParticle();
      particles[i].checkEdges();
      particles[i].update();
    }
    for (i=0; i<tam; i++) {              
      for (j=1; j<tam-1; j++) {
        if (link.checkIfLink(particles[i], particles[j])) {      
          link.displayLink(particles[i], particles[j]);
        }
      }
    }
  }
}
class Particle {
  float randerX;
  float randerY;  
  PVector pos=new PVector();        
  PVector vel=new PVector();        

  Particle () {                   
    randerX=random(2);                
    randerY=random(2);
    pos.x=random(width);
    pos.y=random(height);
    if (randerX<1)
      vel.x=random(1, 3);
    else vel.x=random(-3, -1);
    if (randerY<1)
      vel.y=random(1, 3);
    else vel.y=random(-3, -1);
  }
  void displayParticle() {          
    noStroke();
    fill(255, 100);
    ellipse(pos.x, pos.y, 7, 7);
  }
  void checkEdges() {      
    if (pos.x<=0) {
      vel.x*=(-1);
    }
    if (pos.y<=0) {
      vel.y*=(-1);
    }
    if (pos.x>=width) {
      vel.x*=(-1);
    }
    if (pos.y>=height) {
      vel.y*=(-1);
    }
  }
  void update() {  
    pos.add(vel);
  }
}
class Linker {
  float alpha=0;
  float xDif;
  float yDif;
  float hipoT;
  boolean checkIfLink (Particle p, Particle pp) {    
    hipoT=dist(p.pos.x, p.pos.y, pp.pos.x, pp.pos.y);
    alpha = map( hipoT, 300, 0, 0, 255);
    if (hipoT<300) {
      return true;
    } else {
      return false;
    }
  }
  void displayLink(Particle p, Particle pp) {    
    stroke(255, alpha);
    strokeWeight(5);
    line(p.pos.x, p.pos.y, pp.pos.x, pp.pos.y);
  }
}