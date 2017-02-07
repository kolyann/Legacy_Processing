from pprint import pprint
from GifExporter import GifExport
import os

step = 0;
mX = 300;
mY = 300;
_fRate = 30;

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(360)
    global gifExp
    gifExp = GifExport(False,verbose=True)   
  

def draw():
    global step
    background(360)
    translate(mX/2,mY/2)
    rotate(radians(step))

    strokeWeight(10)
    noFill()
    cs = 30
    co = 180
    mr = 10
    for i in range(1,mr):
        stroke(norm(i,1,mr+1)*360,360,360)    
        arc(0,0,i*cs,i*cs,radians(i*co),radians(i*co)+1.01*PI*3/2 + (2*(i%2)-1)*sin(radians(step))*PI/2)
    '''arc(0,0,90,90,0,PI*3/2 + sin(radians(step))*PI/2)'''
    gifExp.rec()
    step+=3
    if(step>=360):
        gifExp.finish()