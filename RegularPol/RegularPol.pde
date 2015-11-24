import gifAnimation.*;

static float mX = 200;
static float mY = 200;
static float frameR = sqrt(mX*mX + mY*mY)/2;

boolean recording = false;
GifMaker gifExport;
static final int totalFrameRate = 30;
static int anglesAmount = 4;
static final int polygonsAmount = ((int)pow(anglesAmount,2)/2)*4;
static final float radiusDecr = cos(PI/(float)anglesAmount);
static final float radiusIncr = 1/radiusDecr;
static float rotationSpeed = 0.5;
static float increaseSpeed = 1.0;
static float incrCoeff;

void calculateSpeed(){
  float rotationAngle = 180.0 / anglesAmount;
  incrCoeff = pow(increaseSpeed*radiusIncr,1/rotationAngle);
}


RegularPolygon[] RP = new RegularPolygon[polygonsAmount];

void setup() {
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
  if(recording)
    setNewExport();
  colorMode(HSB,360);
  background(360);
  initPolygons(anglesAmount,frameR*radiusIncr);
  calculateSpeed();
  println(polygonsAmount);
}

int startIndex = 0;
float rotAngle = 90.0;
void draw() {
  background(360,360);
  
//  if(recording){
//    recFrame();
//    if(step==0){
//      gifExport.finish();
//    }
//  }
  int tIndex = startIndex;
  for(int i=startIndex;i<RP.length+startIndex;i++)
  {
    int j = i%RP.length;
    RP[j].setAngleRotate(rotAngle);
    if(RP[j].r > frameR*radiusIncr){
      RP[j].setRadius(getSmallestR(RP[j].R));
      tIndex++;
      tIndex = tIndex % RP.length;
    }
    RP[j].setRadius(RP[j].R*incrCoeff);
    RP[j].calculatePoints();
    if(j%2==0)
      fill(0);
    else
      fill(360);
    RP[j].drawPolygon();
  }
  startIndex = tIndex;
  rotAngle += rotationSpeed;
  
}
void recFrame()
{
  gifExport.setDelay(1000/totalFrameRate);
  gifExport.addFrame();
}

void initPolygons(int angles, float startR){
  
  for(int i=0;i<RP.length;i++){
    RP[i] = new RegularPolygon(angles,startR);
    RP[i].setXYOffset(mX/2,mY/2);
    RP[i].setAngleOffset(-90+i*(180.0/angles));
    startR*=cos(PI/angles);
  }
}

float getSmallestR(float R){
  for(int i=0;i<polygonsAmount;i++)
    R*=cos(radians(180/anglesAmount));
  return R;
}

void setNewExport()
{
  String prefix = String.valueOf(System.currentTimeMillis());
  gifExport = new GifMaker(this, this.getClass().getSimpleName().toString()+"_"+prefix+".gif", 1);
  gifExport.setRepeat(0);  
}

