class myrect{
  float x1,y1,x2,y2,x3,y3,x4,y4;
  float h,w,phase,movs;
  public myrect(float _x1, float _y1, float _h, float _w, float _phase){
    x1 = _x1;
    y1 = _y1;
    h = _h;
    w = _w;
    phase = _phase;
    movs = phase;
    refreshMovs(phase);
    refreshCoords();
  }
  
  public void refreshCoords(){
    x2 = x1 + w;
    y2 = y1;    
    x4 = x1 + w*movs;
    y4 = y1 + h;    
    x3 = x4 + w;
    y3 = y4; 
  }
  
  public void spin(){
    x1 = x3 + w*phase;
    w *= -1;
    h *= -1;
    phase *= -1;
    //refreshCoords();
  }
  
  public void refreshMovs(float deg){
    movs = deg*phase;
  }
  
  public void draw(){
    fill(0);
    noStroke();
    fill((min(min(x1,x2),min(x3,x4))+555444)%360,360,360);
    quad(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}
