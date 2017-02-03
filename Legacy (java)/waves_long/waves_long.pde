import gifAnimation.*;

static int mX = 500;
static int mY = 200;
static int border = 40;

boolean recording = true;
GifMaker gifExport;

static final int totalFrameRate = 60;
static final int size = 30; 
static int tail = 200;
static int absModul = mX + tail*2 + border;
int wavesAmount = 10;

Wave[] WV = new Wave[wavesAmount];
float[] waveOffset = new float[wavesAmount];

void setup() {
  size(mX, mY);
  frameRate(totalFrameRate);
  generateWaves();
  if(recording)
    setNewExport();

  colorMode(HSB,360);
}

int step = 0;
void draw() {
  background(360,360);
  //line(mX/2,mY/2,ptdx(angle,1),ptdy(angle,1));
  for(int i=0;i<WV.length;i++)
  {
    WV[i].drawWave((step+(int)waveOffset[i])%absModul,border+0.0,mY/2, 15, 20);
  }
  step+=2;
  step%=absModul;
  
  if(recording)
  {
    recFrame();
    if(step==0)
    {
      gifExport.finish();
      generateWaves();
      setNewExport();
    }
  }
}

void recFrame()
{
  gifExport.setDelay(1000/totalFrameRate);
  gifExport.addFrame();
}

void setNewExport()
{
  String prefix = String.valueOf(System.currentTimeMillis());
  gifExport = new GifMaker(this, "wave_"+prefix+".gif", 1);
  gifExport.setRepeat(0);  
}

void generateWaves()
{
  for(int i=0;i<WV.length;i++)
  {
    waveOffset[i] = random(0,absModul);
    WV[i] = new Wave(absModul);
    WV[i].generateWave(10);
    WV[i].setTail(tail); 
    WV[i].generateColor();
  } 
}
