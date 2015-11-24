import gifAnimation.*;

static float mX = 300;
static float mY = 300;

boolean recording = false;
GifMaker gifExport;
static final int totalFrameRate = 45;
void setup() {
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
  if(recording)
    setNewExport();
  colorMode(HSB,360);
  background(360);
  println();
}

float tx=0;
float ty=mY/2;
float up = 2.5;
float myG = 0;

void draw(){

  randomSeed(int(tx)+1001);
  //background(50,180);
  fill(360,0,360,3);
  rect(0,0,mX,mY);
  fill(240,360,360);
  ellipse(tx-10,ty,10,10);
  tx+=1;
  if(myG <= 0){
    myG = 1+randomGaussian()*15;
    up*=-1;
  }
  else
    myG--;
    ty += up;
  tx%=370;
  
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

