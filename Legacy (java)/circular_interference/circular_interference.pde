import gifAnimation.*;

static final float mX = 400;
static final float mY = 400;
static final float maxRadius = 2*sqrt(mX*mX + mY*mY);

boolean recording = true;
GifMaker gifExport;
static final int totalFrameRate = 30;

int cyrcles = 5;

myCyrcle MC[];
int maxT = 0;
String initVect = new String();
int[] times = new int[cyrcles];
  
void setup(){
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
  if(recording)
    setNewExport();
  colorMode(HSB,360);
  background(360);
  MC = new myCyrcle[cyrcles];

  
  for(int i=0;i<MC.length;i++)
  {
    MC[i] = new myCyrcle(myRandom("4 8"),maxRadius,random(0,mX),random(0,mY),(int)random(3,30),(int)random(0,360),myRandom("2 4"), (int)random(0,maxRadius));
    float tme = ((float)MC[i].maxR / (float)(MC[i].N*MC[i].speed));
    tme = (int)tme;
    if(tme>maxT)
      maxT = (int)tme;
    initVect += MC[i].getInfo();
    //println(MC[i].getInfo());
  }
  //println(initVect);
  
}
void draw() {
  background(330);
  String tmpVect = new String();
  for(int i=0;i<MC.length;i++)
  {
    MC[i].recalcRadiuses();
    MC[i].draw();
    tmpVect += MC[i].getInfo();
  }
  if(recording){
    recFrame();
    if(--maxT == 0)
      gifExport.finish();
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
  gifExport = new GifMaker(this, this.getClass().getSimpleName().toString()+"_"+prefix+".gif", 1);
  gifExport.setRepeat(0);  
}

int myRandom(String str)
{
  String[] SS = str.split(" ");
  int index = (int)random(0,SS.length);
  return Integer.valueOf(SS[index]);
}

