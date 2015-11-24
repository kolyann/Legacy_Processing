import gifAnimation.*;

static float mX = 200;
static float mY = 200;

boolean recording = false;
GifMaker gifExport;
static final int totalFrameRate = 30;
int squaresAmount = 5;
int interval = 0;
float angle = 0;
float speed = 2.0;
float R = sqrt(mX*mY)*0.33;
float sqX, sqY;


void setup() {
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
  if(recording)
    setNewExport();
  colorMode(HSB,360);
  background(360);
  calculateWidths();
  textSize(12);
  textLeading(11);
  textAlign(CENTER);
}


void draw(){
  background(360,360);
  for(float i=interval;i<mX;i+=(sqX+interval))
  {
    for(float j=interval;j<mY;j+=(sqY+interval))
    {
      String s = "";

      s = (i/sqX+j/sqY)%2==0?"\nСОСИ":"\nХУЙ";
      fill(360,360,360);
      text(s,i,j,sqX,sqY);
      fill(360,360,0,5*(dist(R*cos(radians(angle))+mX/2,R*sin(radians(angle))+mY/2,i+sqX/2,j+sqY/2)));
      noStroke();
      rect(i,j,sqX,sqY);
    }
  }
  if(recording)
  {
    if(angle>=360)
      gifExport.finish();
    else
      recFrame();
  }
  angle+=speed;
}

void calculateWidths()
{
  float wdth = mX - interval*(1+squaresAmount);
  float hght = mY - interval*(1+squaresAmount);
  sqX = wdth / squaresAmount;
  sqY = hght / squaresAmount;
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

