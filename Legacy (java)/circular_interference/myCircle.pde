class myCyrcle{
  int N, weight, clr, offset;
  float x,y, maxR, speed;
  float[] radiuses;
  public myCyrcle(int _N, float _maxR, float _x, float _y, int _weight, int _clr, float _speed, int _offset){
    x = _x;
    y = _y;
    N = _N;
    maxR = _maxR;
    speed = _speed;
    weight = _weight;
    clr = _clr;
    offset = _offset;
    radiuses = new float[_N];
    initRadiuses();
  }
  
  public void setXY(float _x, float _y)
  {x=_x;y=_y;}
  
  private void initRadiuses()
  {
    for(int i=0;i<radiuses.length;i++)
      radiuses[i] = (i*maxR/N + offset) % maxR;
  }
  public String getInfo()
  {
    return "N = \t"+N+
        "\nSpeed =\t"+speed+"\n";
//        "\nR1 = \t"+(int)radiuses[1]+
//        "\nRL = \t"+(int)radiuses[radiuses.length-1]+
//        "\n";
  }
  public void recalcRadiuses()
  {
    for(int i=0;i<radiuses.length;i++)
      radiuses[i] = (radiuses[i]+speed) % maxR;
  }
  
  public void draw()
  {
    for(int i=0;i<radiuses.length;i++)
    {
      noFill();
      strokeWeight(min(radiuses[i],weight));
      stroke(clr,360,360,180);
      //stroke(clr,270);
      ellipse(x,y,radiuses[i],radiuses[i]);
    }
  }
}
