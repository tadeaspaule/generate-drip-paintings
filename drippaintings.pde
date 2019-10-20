float maxDist = 400;
float[][] cols;
int nCols = 5;
float coloff = 0.2;

int c = 0;

void setup() {
  size(1920,1080);
  noStroke();
  drawDripPainting();
  //for (int i = 0; i < 10; i++) {
  //  drawDripPainting();
  //  saveFrame("drip" + i + ".png");
  //}
}

void drawDripPainting() {
  background(255);
  nCols = (int)random(2,7);
  cols = new float[nCols][3];
  for (int c = 0; c < nCols; c++) cols[c] = new float[]{random(256),random(256),random(256)};
  for (int i = 0; i < 2000; i++) {
    float x1 = random(width);
    float y1 = random(height);
    float x2 = x1 + random(-maxDist,maxDist);
    float y2 = y1 + random(-maxDist,maxDist);
    float[] col = cols[(int)random(nCols)];
    
    fill(col[0]*random(1-coloff,1+coloff),
         col[1]*random(1-coloff,1+coloff),
         col[2]*random(1-coloff,1+coloff));
    drawCurveLine(x1,y1,x2,y2); 
  } 
}

void drawCurveLine(float x1, float y1, float x2, float y2) {
  float r = random(0.6,2.3); // varies the "roundness" a bit
  float x3 = (x1+x2)*0.5f - r*(y2-y1);
  float y3 = (y1+y2)*0.5f + r*(x2-x1);
  float d = dist(x1,y1,x3,y3);
  // figure out span
  float a = dist(x1,y1,x3,y3);
  float b = dist(x2,y2,x2,y3);
  float c = dist(x1,y1,x2,y2);
  float span = acos((a*a+b*b-c*c)/(2*a*b));
  // figure out startR
  float startR = 0;
  float x4 = x3 - 200;
  float a2 = dist(x3,y3,x4,y3);
  float b2 = dist(x4,y3,x1,y1);
  startR = acos((a*a+a2*a2-b2*b2)/(2*a*a2));
  if (y1 > y3) startR *= -1;
  startR += PI;
  float step = c / 130000;
  float rad = random(2.5,19.5);
  float rad2 = random(2.5,19.5);
  float radstep = (rad2-rad) / (span/step);
  for (int i = 0; i < span/step; i++) {
    float x = x3+d*cos(startR+i*step);
    float y = y3+d*sin(startR+i*step);
    ellipse(x,y,rad+i*radstep,rad+i*radstep);
  }
}
