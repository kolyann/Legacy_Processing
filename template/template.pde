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

void draw() {
  background(360,360);
  println(this);
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

