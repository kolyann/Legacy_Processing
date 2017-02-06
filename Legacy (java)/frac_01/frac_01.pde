import gifAnimation.*;

static float mX = 300;
static float mY = 300;


boolean recording = true;
GifMaker gifExport;
static final int totalFrameRate = 30;
final int maxDepth = 4;

FracLine L;

void setup() {
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
  if(recording)
    setNewExport();
  colorMode(HSB,360);
  background(360);
  L = new FracLine(mX/2,mY/2,0,50,maxDepth,4,maxDepth);
}

float alpha = 0;
void draw() {
  background(0);
  L.a = alpha;
  L.recalc();
  L.draw();
  if(alpha>(-360*8))
    recFrame();
  else
    gifExport.finish();
  alpha -=4;
}

void recFrame()
{
  gifExport.setDelay(1000/totalFrameRate);
  gifExport.addFrame();
}

void setNewExport()
{
  String prefix = String.valueOf(System.currentTimeMillis());
  gifExport = new GifMaker(this, this.getClass().getSimpleName().toString()+"_"+prefix+".gif", 1);
  gifExport.setRepeat(0);  
}

