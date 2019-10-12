World w;
boolean leftClick, rightClick, playB=false, restart=false, space;
float e=1;
String highScore [];
int highScoreI;
int maxRowI;
int r=0;

void setup() {
  size(1200, 680);
  w=new World();  
  noCursor();
  frameRate(60);  
  highScore = loadStrings("highScore.txt");
  highScoreI=Integer.parseInt(highScore[0]);
  maxRowI=Integer.parseInt(highScore[1]);
}
void draw() {


  noStroke();
  fill(12, 50);
  rect(0, 0, width, height);
  highscoreSaver();
  if (restart)
  {
    w=new World();
  }
  w.menu(playB, e);
}
void highscoreSaver() {
  saveStrings(dataPath("highScore.txt"), highScore); 
  if (w.points>highScoreI) {
    highScoreI=(int)w.points;
    highScore[0]=String.valueOf(highScoreI);
  }  
  if (w.row>maxRowI) {
    maxRowI=w.row;
    highScore[1]=String.valueOf(maxRowI);
  }
}
void keyPressed() {
  if (key=='p')
    playB=true;
  if (key==' ')
    space=true;
  if (key=='o')
    playB=false;
  if (key=='r')
    restart=true;
}
void keyReleased() {
  if (key=='p')
    playB=true;
  if (key==' ')
    space=false;
  if (key=='o')
    playB=false;
  if (key=='r')
    restart=false;
}
void mouseWheel(MouseEvent event) {
  e= event.getCount();
  w.t=1;
}
void mousePressed() {
  if (mouseButton==LEFT) {
    leftClick=true;
  }
  if (mouseButton==RIGHT) {
    rightClick=true;
  }
}
void mouseReleased() {
  if (mouseButton==LEFT) {
    leftClick=false;
  }
  if (mouseButton==RIGHT) {
    rightClick=false;
  }
}