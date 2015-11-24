import gifAnimation.*;

static int mX = 250;
static int mY = 250;
static int border = 30;
static float _mX = mX - border;
static float _mY = mY - border;
float angle = 0;//(int)random(360);

boolean recording = false;

GifMaker gifExport;



int size = 5; 
int N = 1;

float fx = 0;
float fy = 0;

void setup() {
  if(recording)
  {
    String gifname = this.getClass().toString().split(" ")[1];
    gifExport = new GifMaker(this, "C:\\Users\\Tigin_NA\\Documents\\trash\\ProcessingGifs\\"+gifname+".gif",1);
    gifExport.setRepeat(0);             // make it an "endless" animation
  }
  size(mX, mY);
  frameRate(30);
  colorMode(HSB,360);
  //gifExport.setTransparent(0,0,0);    // black is transparent
}

void draw() {
  background(360,360);
  angle+=1;
  //line(mX/2,mY/2,ptdx(angle,1),ptdy(angle,1));
  fill(255,255,255,0);

  for(float i=0.1;i<=0.8;i+=0.1)
  {
    for(int j=0;j<N;j++)
      drawTail(j*360/N+angle*(1-i)*10,12,i*1.4,(int)(30*(1-i*i*i))/N,360*(i-0.1)/0.69 - 40);
  }
  if(recording)
  {
    gifExport.setDelay(1000/30);
    gifExport.addFrame();
  
    if(angle==(360/N))
      gifExport.finish(); 
  }

}
void drawTail(float _angle, float direct, float _r, int t, float clr)
{
  for(float i=t;i>0;i-=0.12)  
  {  
    noStroke();
    fill(clr,360,360,192*(t-i+1)/t);
    ellipse(ptdx(_angle-i*direct,_r),ptdy(_angle-i*direct,_r),size*(t-i)/t,size*(t-i)/t);
  }
}

float ptdx(float _fi, float _r)
{
  float tmpx = _r*cos(radians(_fi))/2;
  tmpx *= _mX;
  tmpx += mX/2;
  return tmpx;
}
float ptdy(float _fi, float _r)
{
  float tmpy = _r*sin(radians(_fi))/2;
  tmpy *= _mY;
  tmpy += mY/2;
  return tmpy;
}

