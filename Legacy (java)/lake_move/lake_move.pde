static float mX = 600;
static float mY = 600;
static float border = 50;
static final int totalFrameRate = 20;

void setup() {
  size((int)mX, (int)mY);
  frameRate(totalFrameRate);
 
}
float gx = mX - border;
float gy = mY/2;
float bx = mX/2;
float by = mY/2;
float ga = 0;

void draw() {
  background(255);
  ellipse(mX/2,mY/2,mX-2*border,mY-2*border);
  changeBLocation();
  changeGLocation();
  ellipse(bx,by,10,10);
  ellipse(gx,gy,10,10);
  println("");
}
void changeGLocation()
{
  float gD = mX - 2*border;
  float gt = 4*2.21*degrees(1)/(float)(mX-border);
  
  float gx1 = mX/2+cos(radians(ga+gt))*gD/2;
  float gy1 = mY/2+sin(radians(ga+gt))*gD/2;
  float gx2 = mX/2+cos(radians(ga-gt))*gD/2;
  float gy2 = mY/2+sin(radians(ga-gt))*gD/2;
  float d1 = abs(dist(gx1,gy1,bx,by));
  float d2 = abs(dist(gx2,gy2,bx,by));
  if(abs(d1-d2)<(2/(d1+d2)))
    return;
  if((d1-d2) < 0)
  {
    gx=gx1;
    gy=gy1;
    ga+=gt;
  }
  else if((d1-d2) > 0)
  {
    gx=gx2;
    gy=gy2;
    ga-=gt;
  }

  
}
void changeBLocation()
{
  float D = dist(bx,by,mouseX,mouseY);
  if(D <= 1.0)
    return;
  bx += (mouseX-bx)/abs(D);
  by += (mouseY-by)/abs(D);  
}
void mouseClicked(){
  println(hour()+" "+minute()+" "+second());
}
