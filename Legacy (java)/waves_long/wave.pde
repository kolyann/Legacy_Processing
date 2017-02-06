class Wave
{
  int tailLength;
  int waveLength;
  float[] waveValues;
  
  float clr, dark, bright;
  
  int currentStep = 0;
    public Wave(int _waveLength)
    {
      waveLength = _waveLength;
      waveValues = new float[waveLength];
    }
    
    public void setTail(int _tailLength)
      {tailLength = _tailLength;}
      
    public void generateColor()
    {
        clr = random(0,360);
        dark = random(240,360);
        bright = random(240,360);
    }
    
    public void drawWave(int step, float xoffset, float yoffset, float H, float size)
    {
      int startIndex = step - tailLength;
      if(startIndex<0)
        startIndex=0;
      int endIndex = step;
      if(endIndex>=waveLength)
        endIndex = waveLength;
      float q = 0;
      for(int i=startIndex;i<endIndex;i++)
      {
        q+= (1/(float)tailLength);
        fill(clr,dark,bright,q*360/2);
        noStroke();
        ellipse(i-xoffset-tailLength,yoffset+H*waveValues[i],size*q,size*q);
      }
    } 



    public void generateWave(int sinAmount)
    {
      float[] sincoeffs = new float[sinAmount];
      float[] sinphases = new float[sinAmount];
      float[] sinangles = new float[sinAmount];
      for(int i=0;i<sinAmount;i++)
      {
         sincoeffs[i] = random(0.5,2.0);
         sinangles[i] = random(0.3,3.0);
         sinphases[i] = random(0.0,360.0);
      }
      for(int i=0;i<waveLength;i++)
      {
        float waveVal = 0.0;
        for(int j=0;j<sinAmount;j++)
         waveVal += sincoeffs[j]*sin(radians(i*sinangles[j] + sinphases[j]));
        waveValues[i] = waveVal;
      }
    }
  
}
