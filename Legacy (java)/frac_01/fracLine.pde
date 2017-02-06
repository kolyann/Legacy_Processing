public class FracLine{
  float x1,y1,x2,y2;
  float a,l;
  int depth, N;
  FracLine[] FL;
  int maxDepth;
  public FracLine(float _x, float _y, float _a, float _l, int _depth, int beamAmount, int MD)
  {
    x1 = _x;
    y1 = _y;
    a = _a;
    l = _l;
    depth = _depth;
    //println("Init lvl: "+depth);
    N = beamAmount;
    maxDepth = MD;
    calculateXY2();
    if(depth>0){
      FL = new FracLine[beamAmount];
      for(int i=0;i<FL.length;i++)
        FL[i] = new FracLine(x2,y2,a*(i+1),l*0.75,depth-1,N,MD);//(int)random(0,N+1));
    }
  }
  
  private void calculateXY2(){
    x2 = x1 + l*cos(radians(a));
    y2 = y1 - l*sin(radians(a));
  }
  
  public void recalc(){
    calculateXY2();
    if(depth>0)
      for(int i=0;i<FL.length;i++)
      {
        FL[i].x1 = x2;
        FL[i].y1 = y2;
        FL[i].a = -2*a*(1+i)/FL.length;
        FL[i].recalc();
      }
  }
  public void draw(){
    calculateXY2();
    if(depth>0)
      for(int i=0;i<FL.length;i++)
        FL[i].draw();
    strokeWeight(depth+1);
    stroke(200,360,360,180+180*(depth+1)/maxDepth);
    line(x1,y1,x2,y2);
  }
  
  //public static void setMaxDepth(int MD){maxDepth = MD;}
}
