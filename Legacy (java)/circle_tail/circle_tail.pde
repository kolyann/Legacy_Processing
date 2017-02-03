static int mX = 250;
static int mY = 250;
float angle1 = 0;//(int)random(360);
float angle2 = 0;
int size = 40; 
float d1 = 7.1;
float d2 = 7.1;
float diffangle = 3;

float fx = 0;
float fy = 0;

void setup() {
  size(mX, mY);
  frameRate(60);
}

void draw() {

  //int _x1 = mX/2 + (int)(cos(radians(angle1))*mX/2);
  //int _y1 = mY/2 + (int)(sin(radians(angle2)) * mY/2);
  background(255);
  drawTail(40);
  angle1 += d1;
  angle2 += d2;

  
  //ellipse(_x1,_y1,size,size);
  
}

void drawTail(int t)
{
  for(int i=t;i>0;i--)  {
    float _x1 = mX/2 + (cos(radians(angle1-i*d1))*mX/2);
    float _y1 = mY/2 + (sin(radians(angle2-i*d2))*mY/2);
    noStroke();
    fill(0,255*(t-i)/t);
    ellipse(_x1,_y1,size*(t-i)/t,size*(t-i+1)/t);
  }
}

void setXYbyAngle(float angle)
{
  float tc = (1+sin(radians(angle*diffangle)))/2;
  float ax = (cos(radians(angle)));
  float ay = (sin(radians(angle)));
  
}
