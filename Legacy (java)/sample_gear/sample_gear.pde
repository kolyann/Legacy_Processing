import gifAnimation.*;

static final float mX = 300;
static final float mY = 300;

boolean recording = false;
GifMaker gifExport;
static final int totalFrameRate = 30;

void setup() {
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
  if(recording)
    setNewExport();
  colorMode(HSB,360);
  background(360);

}

float r = 80;
float zX = 18;
float zY = 24;
int zubs = 12;

float step=0;
void draw() {
  background(360,360);
  translate(mX/2,mY/2);
  for(int i=0;i<zubs;i++)
  {
    pushMatrix();
    rotate(2*i*PI/zubs);
    rotate(radians(step));
    rect(-zX/2,r-zY/2+11*sin(radians(step+i*30)),zX,zY);
    popMatrix();
  }
  ellipse(0,0,2*r,2*r);
  stroke(1);
  step+=2;
}

void recFrame()
{
  gifExport.setDelay(1000/totalFrameRate);
  gifExport.addFrame();
}

void setNewExport()
{
  String prefix = String.valueOf(System.currentTimeMillis());
  String path = System.getenv("USERPROFILE")+"\\Pictures\\ProcessingResult\\";
  gifExport = new GifMaker(this, path+this.getClass().getSimpleName().toString()+"\\"+prefix+".gif", 1);
  gifExport.setRepeat(0);  
}

