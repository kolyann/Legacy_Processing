
static int mX = 250;
static int mY = 250;
static int step = 10;
int t = 0;

float angle = 0;
void setup() {
  size(mX, mY);
}

void draw() { 
  frameRate(60); 
  background(255);
  t++;
  for(int i=0;i<10;i++)
  {
    drawSnake(t+8*i);
  }
  
}

void drawSnake(int move)
{
  for(int i=mX+step;i>=-step;i-=step/2)
  {
    float _y = mY/2 * sin(radians(i+move)) + mY/2;
    noStroke();
    fill(0,256*_y/mY);
    ellipse(i,_y,step*2,step*2); 
  }
}




