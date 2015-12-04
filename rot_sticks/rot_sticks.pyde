from pprint import pprint
import imp
'''import Processing lib gifAmimation "http://extrapixel.github.io/gif-animation/"'''
myimp = imp.load_source('gifExporter',
        ''.join([os.environ['USERPROFILE'],
                 '\\Documents\\Processing\\py_template\\gifexp\\GifExporter.py']))
from gifExporter import gifExport
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
    gifExp = gifExport(True,verbose=True)   
    

def draw():
    global step
    background(360)
    netSize = 50
    translate(-netSize/2,-netSize/2)
    
    tx = int(mX/netSize+2)
    ty = int(mY/netSize+2)
    for i in range(tx):        
        for j in range(ty):
            fill(0)
            ellipse(0,0,5,5)
            t = radians(step) * (((i+j) % 2)*2-1)
            rotate(t)
            strokeWeight(3)
            line(0,0,50,0)
            rotate(-t)
            
            translate(netSize,0)
        translate(-(ty)*netSize,0)
        translate(0,netSize)

    if(step>=360):
        gifExp.finish()
    gifExp.rec()
    step+=3
