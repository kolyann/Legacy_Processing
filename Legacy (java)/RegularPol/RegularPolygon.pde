class RegularPolygon
{
  int N;
  float R,r;
  float angleRotate = 0;
  float angleOffset = 0;
  float[] xPoints, yPoints;
  float xOff = 0, yOff = 0;
  
  public RegularPolygon(int _N, float _R){
    if(_N<3)
      throw new RuntimeException("Polygon must have at least 3 points");
    N = _N;
    R = _R;
    r = R*cos(radians(180/N));
    xPoints = new float[N];
    yPoints = new float[N];
  }
  
  public void drawPolygon(){
    
    //fill(130,360,100);
    //noFill();
    beginShape();
    for(int i=0;i<N;i++){
      noStroke();
      //strokeWeight(0);
      vertex(xPoints[i],yPoints[i]);
      strokeJoin(ROUND);
    }
    endShape(CLOSE);
    
  }
  
  public void calculatePoints(){
    for(int i=0;i<N;i++){
      xPoints[i] = R*cos(radians((i*360)/N + angleOffset + angleRotate)) + xOff;
      yPoints[i] = R*sin(radians((i*360)/N + angleOffset + angleRotate)) + yOff;
    }
    return;
  }
  
  public void setAngleOffset(float AO){angleOffset = AO;}
  public void setAngleRotate(float AR){angleRotate = AR;}
  public void setXYOffset(float _X, float _Y){xOff = _X; yOff = _Y;}
  public void setRadius(float _R){R = _R;r = R*cos(radians(180/N));}
}
