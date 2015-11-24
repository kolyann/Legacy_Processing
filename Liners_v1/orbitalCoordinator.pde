class orbitalCoordinator
{
  
  int N;
  float cx, cy;
  float R;
  float[] xRadCoords, yRadCoords, angleOffset, rCoefficient;
  public orbitalCoordinator(int _N)
  {
    N = _N;
    xRadCoords = new float[N];
    yRadCoords = new float[N];
    angleOffset = new float[N];
    rCoefficient = new float[N];
  }
  
  public void calculateCoords(float angle, float clue, float cluePosOffset)
  {
    for(int i=0;i<N;i++)
      angleOffset[i] = (180/N)*cos((PI*clue)*sin(radians(360*i/N+angle+cluePosOffset)));
    
    for(int i=0;i<N;i++)
    {
      xRadCoords[i] = cx + gX(angle+360*i/N+angleOffset[i]);
      yRadCoords[i] = cy + gY(angle+360*i/N+angleOffset[i]);
    }
  }
  
  public float[] getXCoords(){return xRadCoords;}
  public float[] getYCoords(){return yRadCoords;}
  public float[] getXY(int i){
    float[] singleCoord = new float[2];
    singleCoord[0] = xRadCoords[i];
    singleCoord[1] = yRadCoords[i];
    return singleCoord;
  }
  
  
  public void setR(float _R){R=_R;}
  public void setCenter(float _x, float _y){cx=_x;cy=_y;}
  private float gX(float angle){return R*cos(radians(angle));}
  private float gY(float angle){return R*sin(radians(angle));}
  
}
