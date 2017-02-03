class myLiners
{
  float ax1, ay1, ax2, ay2;
  float bx1, by1, bx2, by2;  
  public myLiners()
  {
  }

  private float[] splitPoint(float _p1, float _p2, int _n)
  {
    //check if _p1 == _p2
    float distance = max(_p1,_p2) - min(_p1,_p2);
    float[] points = new float[_n+1];
    int mult;
    if(_p2 > _p1)
      mult = 1;
    else
      mult = -1;
    for(int i=0;i<=_n;i++)
      points[i] = _p1 + (distance * i * mult)/(float)_n; 
    return points;
  }
  
  private float[] splitPointWithK(float _p1, float _p2, int _n, float _k)
  {
    float distance = max(_p1,_p2) - min(_p1,_p2);
    float[] points = new float[_n+1];
    int mult;
    if(_p2 > _p1)
      mult = 1;
    else
      mult = -1;
    float a1 = 2*distance / ((_k+1)*_n);
    float an = a1 * (_k+1);
    float difference = (an - a1)/(_n-1);
    //points[0] = _p1;
    int j=0;
    for(int i=0;i<=_n;i++)
    {
      points[i] = _p1 + mult * (difference * j);
      j = j+i;
    } 
    return points;
  }
  
  public void draw(int _n, float _k)
  {
    float[] axpts = splitPointWithK(ax1,ax2,_n,_k);
    float[] aypts = splitPointWithK(ay1,ay2,_n,_k);
    float[] bxpts = splitPointWithK(bx1,bx2,_n,_k);
    float[] bypts = splitPointWithK(by1,by2,_n,_k);
    for(int i=_n;i>=0;i--)
    {
      fill(360,360,360);
      //stroke(360,360,360);
      //ellipse(axpts[i],aypts[i],5+i,5+i);
      //ellipse(bxpts[i],bypts[i],5+i,5+i);
      stroke(360*i/_n,360,360,180);
      //stroke(360);
      line(axpts[i],aypts[i],bxpts[i],bypts[i]); 
    }
  }
  
  public void draw(int _n)
  {
    float[] axpts = splitPoint(ax1,ax2,_n);
    float[] aypts = splitPoint(ay1,ay2,_n);
    float[] bxpts = splitPoint(bx1,bx2,_n);
    float[] bypts = splitPoint(by1,by2,_n);
    for(int i=_n;i>0;i--)
    {
      stroke(360*i/_n,360,360,290);
      line(axpts[i],aypts[i],bxpts[i],bypts[i]); 
    }
  }
 
  public void setAXY(float _x1, float _y1, float _x2, float _y2)
  {
    ax1 = _x1;
    ay1 = _y1;
    ax2 = _x2;
    ay2 = _y2;
  }
  public void setBXY(float _x1, float _y1, float _x2, float _y2)
  {
    bx1 = _x1;
    by1 = _y1;
    bx2 = _x2;
    by2 = _y2;
  }
}
