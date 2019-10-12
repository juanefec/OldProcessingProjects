class World { 
  
  ArrayList <Enemy> enemyS = new ArrayList <Enemy>();
  ArrayList <Shot> shotS = new ArrayList <Shot>();
  Shoter shoter = new Shoter();
  MenuBackground backgroundM=new MenuBackground();
  PVector antiDif, dir1, dir2, dir3, dir4;

  int life=250;  
  float strike;
  int tKills;
  int rowTime=400;
  int row;
  int bestRow;
  float points;
  int Level;

  float seconds;  
  int minutes;

  int i=0;
  int ind=0; 
  int j;

  float radius=0;
  boolean mButton;   
  float preE;
  int t=1;
  int et=1;
  int enemyTimer=30;
  int a=0;
  float ulti=400;
  int loadShotgunT=20; 
  void menu(boolean playB, float e) {
    timer();
    fill(0, 102, 153);
    textSize(32);
    if (life<=0) {
      backgroundM.run();
      noStroke();
      textSize(70);
      fill(255, 0, 0);
      text("DEAD!", 480, 250);
      textSize(32);
      text("Score: "+int(points)+"\nBestRow: "+bestRow+"\nT Kills: "+tKills, 480, 290);
      textSize(42);
      text("R to restart", 475, 435);
      playB=false;
    }   
    if (playB) {
      run(rightClick, leftClick, e);
    } else if (life>0) {
      backgroundM.run();
      noStroke();
      fill(100, 240, 180);
      textSize(18);
      text("Use the mouse to move.\n\n\n\nUse the right click to shot backward.\n\n\n\nUse the left click to shoot forward.", 850, 220);
      text("Scroll up for Shotgun.\n\nScroll down for UZI.", 30, 140);
      //text("EASY\n\nNORMAL\n\nHARD\n\nHARDER", 30, 370);
      text("*This game is probably only well experiencied with a mouse", 9, 30);
      textSize(62);
      text("Press P to play\n\nPress O to pause\n\nPress R to restart", 320, 160);      
      fill(220, 10);
      rect(240, 40, 700, 600);
      rect(840, 180, 350, 300);
      rect(15, 115, 220, 110);
      /*rect(15, 325, 220,260);
      rect(20, 345, 170,40);
      rect(20, 400, 170,40);
      rect(20, 455, 170,40);
      rect(20, 510, 170,40);*/
      fill(200, 90);
      ellipse(mouseX, mouseY, 30, 30);
     
    }
  }
  void run(boolean rM, boolean lM, float e) {    
    pointCount();
    shoter.displayUpdate();    
    checkShotWalls();
    checkEnemyDead(Level);
    checkDamage();
    enemyManager();
    ultiUser();
    stuffDisplay();
    dumpeR();
    for (Shot s : shotS) {     
      s.displayShot();
    }
    for (Enemy ens : enemyS) {
      ens.displayUpdate(shoter.loc);
    }
    if (lM && !rM) {
      mButton=false;
      shoot(mButton, e);
    } else if (rM && !lM) {
      mButton=true;
      shoot(mButton, e);
    } else {
      t=1;
    }
    if (e!=preE) {
      if (e==1) {
        fill(200, 160);
        rect(335, 60, 200, 80);
        fill(230);
        rect(345, 70, 80, 60);
        fill(0);
        text("UZI", 355, 110);
      } else if (e==-1) {
        fill(200, 160);
        rect(335, 60, 200, 80);
        fill(230);
        rect(435, 70, 80, 60);
        fill(0);
        textSize(19);
        text("Shotgun", 438, 105);
      }
    }    
    preE=e;
  }
  void timer() {
    if (playB){
      seconds=millis();
      println(seconds);
    }else {
      seconds=0;
    }
  }
  
  void enemyManager() {
    et--;
    if (et<1) {
      enemyS.add(new Enemy(2));
      enemyTimer++;
      if (enemyTimer>20){        
        if (a<=24)a++;
        enemyTimer=0;
      }
      et=30-a;
    }
    println(a);
    println(et);
  }
  void ultiUser() {
    if (ulti<=0) {
      if (space) {  
        if (radius<1100) {  
          ultiEffect();  
          radius+=15;
          fill(180, 70);
          ellipse(shoter.loc.x, shoter.loc.y, radius, radius);
        }
      } else {
        if (radius>0) {
          ulti=400;
        }
        radius=0;
      }
    }
  }
  void ultiEffect() {    
    for (i=enemyS.size ()-1; i>=0; i--) {
      Enemy ens = enemyS.get(i);
      if (dist(ens.loc.x, ens.loc.y, shoter.loc.x, shoter.loc.y)<=radius/2) {
        fill(180, 120);
        ellipse(ens.loc.x, ens.loc.y, 75, 75);
        enemyS.remove(i);
        points+=10; 
        row++;
        rowTime=400;
        tKills++;
        textSize(32);     
        text(" +10", 170, 30);
      }
    }
  } 
  void checkDamage() {
    if (life>9)
      for (Enemy ens : enemyS) {        
        if (abs(dist(ens.loc.x, ens.loc.y, shoter.loc.x, shoter.loc.y))<30) {
          life-=20;
          fill (205, 0, 0,90);
          ellipse(shoter.loc.x, shoter.loc.y, 45, 45);
        }
      }
  }
  void pointCount() {
    if(row>bestRow)bestRow=row;
    if (ulti>=0.1) {
      ulti-=0.5;
    } else {
      ulti=0;
      textSize(28);
      fill(230, 140);
      text("READY!", 315, 55);
    }
    if (rowTime>0) {
      rowTime-=4;
    } else {
      row=0;
    }
    strike=0.125;
    textSize(40);
    if (row>=15 && row<=29) { 
      strike=0.25;      
      fill(190, 40, 210);
      text("x2", 155, 80);
    } else if (row>=30 && row<=49) {
      fill(190, 40, 90);
      text("x4", 140, 80);
      strike=0.5;
    } else if (row>=50 && row<=74) {
      fill(255, 0, 0);
      text("x8", 155, 80);
      strike=0.75;
    } else  if (row>=75 && row<=99) {
      fill(200, 50, 100);
      text("x16", 155, 80);
      strike=1;
    } else if (row>=100 && row<=179) {
      fill(0, 250, 150);
      text("x32", 155, 80);
      strike=1.25;
    } else if (row>=180  && row<=329) {
      fill(255);
      text("x64", 155, 80);
      strike=1.5;
    } else if (row>=340) {
      fill(255);
      textSize(47);
      stroke(255, 0, 0);
      text("x128", 155, 80);
      strike=2;
    } else {
      enemyTimer=17;
    }
    points+=strike;
  }
  void stuffDisplay() {
    noStroke();
    fill(200, 100, 80);    
    rect(315, 8, rowTime, 20);
    fill(0, 102, 153);
    textSize(32);
    text("Points:"+ int(points), 10, 30);
    text("Kills:"+ tKills, 10, 65);
    text("Row:"+ row, 10, 100);
    text("Max Row:"+ maxRowI, 970, 105);
    text("Max Points:"+ highScoreI, 920, 65);
    fill(60, 240, 170, 80);    
    rect(920, 10, life, 20);
    fill(230, 140);
    rect(315, 32, ulti, 20);
  }
  void dumpeR() {
    for (j=shotS.size ()-1; j>=0; j--) {        
      Shot s=shotS.get(j);
      if (s.hit) {
        shotS.remove(j);
      }
    }
    for (i=enemyS.size ()-1; i>=0; i--) {
      Enemy ens = enemyS.get(i);
      if (ens.dead) {
        enemyS.remove(i);
      }
    }
  }
  void checkEnemyDead(int Level) { 

    for (j=shotS.size ()-1; j>=0; j--) {        
      Shot s=shotS.get(j);
      for (i=enemyS.size ()-1; i>=0; i--) {
        Enemy ens = enemyS.get(i);        
        if (dist(ens.loc.x, ens.loc.y, s.loc.x, s.loc.y)<19) {         
          fill(180, 100);
          ellipse(s.loc.x, s.loc.y, 40, 40);
          s.hit=true;
          ens.enemyLife-=1;          
          if (ens.enemyLife<1) {                
            rowTime=400;
            row++;   
            points+=10; 
            ens.dead=true;           
            tKills++;         
            textSize(32);     
            text(" +10", 170, 30);            
          }
        }
      }
    }
  }

  void shoot(boolean d, float e) {  
    antiDif = shoter.dif.get();
    antiDif.mult(-1);  
    dir1=shoter.dif.get();
    dir2=shoter.dif.get();
    dir3=shoter.dif.get();
    dir4=shoter.dif.get();
    dir1.rotate(-QUARTER_PI/4);
    dir2.rotate(-QUARTER_PI/8);
    dir3.rotate(QUARTER_PI/8);
    dir4.rotate(QUARTER_PI/4);
    if (e==1) {
      t--;
      if (t==0) {
        t=3;
        if (!d) {          
         shotS.add(new Shot(shoter.loc, shoter.dif, 230, 150, 30));
        } else {
         antiDif = shoter.dif.get();
         antiDif.mult(-1);
         shotS.add(new Shot(shoter.loc, antiDif, 30, 150, 230));
        }
        //if (!d) { 
         
        //  shotS.add(new Shot(shoter.loc, dir1, 230, 150, 30));
        //  shotS.add(new Shot(shoter.loc, dir2, 230, 150, 30));
        //  shotS.add(new Shot(shoter.loc, dir3, 230, 150, 30));
          
        //} else {
          
        //  dir2.mult(-1);
        //  dir3.mult(-1);
        
        //  shotS.add(new Shot(shoter.loc, antiDif, 30, 150, 230));
         
        //  shotS.add(new Shot(shoter.loc, dir2, 30, 150, 230));
        //  shotS.add(new Shot(shoter.loc, dir3, 30, 150, 230));
          
        //}
      }
    } else if (e==-1) {
      t--;
      if (t==0) {
        t=loadShotgunT;            
        if (!d) { 
          shotS.add(new Shot(shoter.loc, shoter.dif, 230, 150, 30));
          shotS.add(new Shot(shoter.loc, dir1, 230, 150, 30));
          shotS.add(new Shot(shoter.loc, dir2, 230, 150, 30));
          shotS.add(new Shot(shoter.loc, dir3, 230, 150, 30));
          shotS.add(new Shot(shoter.loc, dir4, 230, 150, 30));
        } else {
          dir1.mult(-1);
          dir2.mult(-1);
          dir3.mult(-1);
          dir4.mult(-1);
          shotS.add(new Shot(shoter.loc, antiDif, 30, 150, 230));
          shotS.add(new Shot(shoter.loc, dir1, 30, 150, 230));
          shotS.add(new Shot(shoter.loc, dir2, 30, 150, 230));
          shotS.add(new Shot(shoter.loc, dir3, 30, 150, 230));
          shotS.add(new Shot(shoter.loc, dir4, 30, 150, 230));
        }
      }
    }
  }
  void checkShotWalls() {
    for ( i = shotS.size ()-1; i>=0; i--) {
      Shot s = shotS.get(i);
      if (s.loc.x<0 || s.loc.y<0) {
        fill(180, 90);
        ellipse(s.loc.x, s.loc.y, 40, 40);
        s.hit=true;
      } else 
        if (s.loc.x>width || s.loc.y>height) {
        fill(180, 90);
        ellipse(s.loc.x, s.loc.y, 40, 40);
        s.hit=true;
      }
    }
  }
}