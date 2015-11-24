import gifAnimation.*;

static final float mX = 300;
static final float mY = 300;

boolean recording = false;
GifMaker gifExport;
static final int totalFrameRate = 30;
myrect[] rects;
int rectsX = 80;
int rectsY = 27;

float xsize;
float ysize;

float t;
boolean spinflag;


void setup() {
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
  if(recording)
    setNewExport();
  colorMode(HSB,360);
  background(360);
  t = 0;
  xsize = 2 * mX / (rectsX-1);
  ysize = 2 * mY / (rectsY-1);
  
  //xsize = 30;
  //ysize = 30;
  
  rects = new myrect[rectsX*rectsY];
  int tmpsign = 1;
  int q = 0;
  
  for(int i=0;i<rectsX;i++){
    for(int j=0;j<rectsY;j++){
      rects[j*rectsX+i] = new myrect(j*2*xsize-xsize*(i%2)/2,i*ysize,ysize,xsize/2,tmpsign);
    }
    tmpsign *= -1;
  }
  
  spinflag = false;
}

boolean block;



void draw() {
  background(360,360);
  float v = sin(radians(t));
  int sgn = (int)Math.signum(v);
  //translate(-xsize*0.5,-ysize-0.5);
  translate(-xsize*2.5,-ysize*0.33);
  for(int i=0;i<rects.length;i++){
    rects[i].refreshMovs(sgn*min(abs(v*2),1));
    rects[i].refreshCoords();
    rects[i].draw();
  }
  
  if(min(abs(v*2),1) == 1){
    if(spinflag){
      for(int i=0;i<rects.length;i++)
        rects[i].spin();
      spinflag = false;
    }
  }
  
  if(min(abs(v*2),1) < 1 && !spinflag){
    spinflag = true;
  }
  
  if(recording){
    if(t<720)
        recFrame();        
    else
      gifExport.finish();
  }
  t+=3;

  //translate(0,mY/2);
  //ellipse(mX/2,sgn*min(abs(v*100),80),30,30);
    
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

