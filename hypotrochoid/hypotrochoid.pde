import gifAnimation.*;

static int mX = 250;
static int mY = 250;
static int border = 30;
static float _mX = mX - border;
static float _mY = mY - border;
float angle = 0;//(int)random(360);
boolean recording = true;
GifMaker gifExport;

int size = 15; 
int N = 1;
float R = 1;
float r = 0.6;
float h = 1.5;

void setup() {
  if(recording)
  {
    gifExport = new GifMaker(this, "C:\\Users\\Tigin_NA\\Documents\\trash\\ProcessingGifs\\hypotro_1.gif",1);
    gifExport.setRepeat(0);             // make it an "endless" animation
  }
  size(mX, mY);
  frameRate(60);
  colorMode(HSB,360);
  
  //gifExport.setTransparent(0,0,0);    // black is transparent
}

void draw() {
 
  //background(360,360);
  angle+=0.1;
  //line(mX/2,mY/2,ptdx(angle,1),ptdy(angle,1));
  fill(255,255,255,0);
  println(angle+" "+ptdx(angle));
  drawTail(angle);
  if(angle > 18.7)
  {
    if(recording)
    {
      gifExport.setDelay(1000/30);
      gifExport.addFrame();
    
      if(angle > 18.7*3)
        gifExport.finish(); 
    }
  }

}
void drawTail(float _angle)
{
    noStroke();
    fill((_angle*(180.0/18.7))%360,360,360);
    ellipse(ptdx(_angle),ptdy(_angle),size,size);
}

float ptdx(float fi)
{
  float tmpx = (R-r)*cos(fi)+h*cos(fi*(R-r)/r);
  tmpx *= mX/5;
  tmpx += mX/2;
  return tmpx;
}
float ptdy(float fi)
{
  float tmpy = (R-r)*sin(fi)-h*sin(fi*(R-r)/r);
  tmpy *= mX/5;
  tmpy += mY/2;
  return tmpy;
}

