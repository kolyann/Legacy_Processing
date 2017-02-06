from pprint import pprint
from GifExporter import GifExport

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
    print gifExp.__doc__   
    

def draw():
    global step

    
    gifExp.rec()
    step+=1