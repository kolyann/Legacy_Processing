from pprint import pprint
import imp
'''import Processing lib gifAmimation "http://extrapixel.github.io/gif-animation/"'''
myimp = imp.load_source('gifExporter',
        ''.join([os.environ['USERPROFILE'],
                 '\\Documents\\Processing\\py_template\\gifexp\\GifExporter.py']))
from gifExporter import gifExport
import os

from Cycle import Cycle
#def __init__(self, lng, al, speed=1, x0=None, y0=None, P=None)


step = 0;
mX = 300;
mY = 300;
_fRate = 240;

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(0)
    global gifExp
    gifExp = gifExport(False,verbose=True)  
    global Cyc1, Cyc2
    Cyc1 = Cycle(40,2,P=Cycle(20,-0.5))
    Cyc2 = Cycle(40,5,P=Cycle(65,-6))

def draw():
    translate(width/2,height/2)
    rotate(radians(-90))
    #background(360)
    global step
    x1,y1 = Cyc1.get_coord()
    x2,y2 = Cyc2.get_coord()
    noStroke()
    fill(190,360,300,90)
    ellipse((x1+x2)/2,(y1+y2)/2,5,5)
    Cyc1.update()
    Cyc2.update()
    gifExp.rec()
    step+=1