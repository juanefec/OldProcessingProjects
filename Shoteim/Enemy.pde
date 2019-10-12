class Enemy {
  PVector loc;
  PVector vel;
  PVector dir;  
  float rander;
  int enemyLife=0;
  int preLife;
  int Level;
  float radius=38;
  color lvl1=color(#EA8282);
  color lvl2=color(#D34B4B);
  color lvl3=color(#DB5E1F);
  color lvl4=color(#DE9E26);  
  boolean dead=false;
  Enemy (int level) {
    rander=random(100);
    if (rander>75) 
      loc =new PVector (random(width), -30);    
    if (rander<75 && rander>50) 
      loc =new PVector (-30, random(height));    
    if (rander<50 && rander>25) 
      loc =new PVector (random(width), (height+30));    
    if (rander<25) 
      loc =new PVector ((width+30), random(height));
    vel =new PVector();
    dir=new PVector ();
    this.Level=level;
    enemyLife=level;
  }
  void displayUpdate (PVector locShoter) {
    if (preLife>300 && preLife<500) { 
      fill(25, 230, 240);
    } else  if (preLife>500 && preLife<700) {
      fill(180, 230, 140);
    } else {
      if (enemyLife==4) {
        noStroke();
        fill(lvl4);
        radius=49;
      } else  if (enemyLife==3) {
        noStroke();
        fill(lvl3);
        radius=45;
      } else if (enemyLife==2) {
        noStroke();
        fill(lvl2);
        radius=41;
      } else if (enemyLife==1) {
        noStroke();
        fill(lvl1);
        radius=38;
      }
    }
    ellipse(loc.x, loc.y, radius, radius);
    if (preLife>300 && preLife<500) { 
      fill(25, 230, 240);
    } else  if (preLife>500 && preLife<700) {
      fill(180, 230, 140);
    }
    dir= PVector.sub(locShoter, loc);
    dir.normalize();
    vel= dir;
    if (preLife<300) {
      preLife++;
      loc.add(PVector.mult(vel, 4.20));//<--
    } else if (preLife<500) {
      preLife++;
      loc.add(PVector.mult(vel, 9));
    } else if (preLife<700) {
      preLife++;
      loc.add(PVector.mult(vel, 14));
    } else {
      loc.add(PVector.mult(vel, 22));
    }
  }
}