from pprint import pprint
import GifExporter
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
    gifExp = GifExporter.GifExport(False,verbose=True)   
    

def draw():
    global step

    
    gifExp.rec()
    step+=1