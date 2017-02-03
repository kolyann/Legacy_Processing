static int mX = 250;
static int mY = 250;
static int border = 30;
float angle = 0;//(int)random(360);


int size = 10; 
int tailLength = 100;
float tailcoeff = 0.21;
float diffangle = 10;
int dots = 15;
float epilepticconst=1;
float axcoef = 1;
float aycoef = 1;


float fx = 0;
float fy = 0;
float tc = 1;

float red=0;
float green=0;
float blue=0;

void setup() {
  size(mX, mY);
  frameRate(120);
}

void draw() {
 
  background(255);
  setXYbyAngle(angle);
  angle+=0.5;
  //if(sin(radians(angle*diffangle))<-0.7)
  //  angle+=0.5;
  for(float i=0;i<dots;i++)
  {
    drawTail(tailLength,i*360/dots);
  }
  //ellipse(mX/2,mY/2,size*2,size*2);  
}

void drawTail(int t, float angleoffset)
{
  for(int i=t;i>0;i--)  
  {
    setXYbyAngle(angle-i*tailcoeff+angleoffset);
    noStroke();
    setColor(angle-i*tailcoeff+angleoffset);
    fill(red,green,blue,tc*tc*255*(t-i)/t);
    ellipse(fx,fy,size*(t-i)/t,size*(t-i)/t);
  }
}

void setXYbyAngle(float _angle)
{
  _angle*=epilepticconst;
  tc = (1+sin(radians(_angle*diffangle)))/2;
  float ax = (cos(axcoef*radians(_angle)));
  float ay = (sin(aycoef*radians(_angle)));
  fx = mX/2 + tc*ax*(mX-border)/2;
  fy = mY/2 + tc*ay*(mY-border)/2;
}

void setColor(float _angle)
{
   float ta = _angle % 360;
   red = 0;
   green = 0;
   blue = 0;
   if(ta >= 0 && ta < 240)
   {
     red = 255*(120 - abs(ta - 120))/120;
   }
   if(ta >= 120 && ta < 360)
   {
     green = 255*(120 - abs((ta-120) - 120))/120;
   }
   if( (ta >= 240 && ta <= 360) || (ta >= 0 && ta < 120))
   {
     ta+=120;
     ta%=360;
     blue = 255*(120 - abs(ta - 120))/120;
   }

}

