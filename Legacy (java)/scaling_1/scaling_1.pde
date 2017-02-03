import gifAnimation.*;

static final float mX = 300;
static final float mY = 300;

boolean recording = true;
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


int step = 0;
int amount = 8;
int fig = 0;
int figs = 3;
int stepRotate = 1;
int recStep = 0;

void draw() {
  translate(mX/2,mY/2);
  //background(360,0,360,10);
  for(int i=0;i<amount;i++)
  {
    pushMatrix();
    rotate(2*i*PI/amount);
    rotate(step*stepRotate);
    switch(fig){
      case 0:rect(step*sqrt(step),step*sqrt(step),step*sqrt(sqrt(step))+2,step*sqrt(sqrt(step))+2);
        break;
      case 1:ellipse(step*sqrt(step),step*sqrt(step),min(step*sqrt(step),1+step*2),min(step*sqrt(step),1+step*2));
        break;
      case 2:triangle(step*sqrt(step),0,step*sqrt(step)+1.5*step,-step,step*sqrt(step)+1.5*step,step);
        break;
    }
    
    popMatrix();
  }
  step++;
  if(step*sqrt(step) > mX*sqrt(2)/2){
    step=0;
    fig++;
    fig%=figs;
    stepRotate *= 1;
    recStep++;
  }
  if(recording){
    if(recStep >= 3)
      recFrame();
    if(recStep >= 6)
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
  String path = System.getenv("USERPROFILE")+"\\Pictures\\ProcessingResult\\";
  gifExport = new GifMaker(this, path+this.getClass().getSimpleName().toString()+"\\"+prefix+".gif", 1);
  gifExport.setRepeat(0);  
}

