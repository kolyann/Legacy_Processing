import gifAnimation.*;

static float mX = 300;
static float mY = 300;
static float frameR = sqrt(mX*mX + mY*mY)/2;

boolean recording = false;
GifMaker gifExport;
static final int totalFrameRate = 30;
static final int anglesAmount = 4;
static float clueCoefficient = 0.4;
static float cluePosOffset = 90;

myLiners[] ML;
orbitalCoordinator OC;
void setup() {
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
  if(recording)
    setNewExport();
  colorMode(HSB,360);
  //background(360);
  OC = new orbitalCoordinator(anglesAmount);
  OC.setR(150);
  OC.setCenter(mX/2,mY/2);
  ML = new myLiners[anglesAmount];
  for(int i=0;i<anglesAmount;i++)
    ML[i] = new myLiners();
}

float angle = 0;
void draw() {
  int K = 20;
  background(0);
  strokeWeight(2);
  OC.calculateCoords(angle,clueCoefficient,cluePosOffset);
  for(int i=0;i<anglesAmount;i++)
  {
    ML[i].setAXY(OC.cx,OC.cy,OC.getXY(i)[0],OC.getXY(i)[1]);
    ML[i].setBXY(OC.getXY((i+1)%anglesAmount)[0],
                 OC.getXY((i+1)%anglesAmount)[1],OC.cx,OC.cy);
    ML[i].draw(K);
  }

  angle+=0.5;
  //line(0,mY/2,mX,mY/2);
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

