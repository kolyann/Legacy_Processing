from pprint import pprint
import imp
myimp = imp.load_source('gifExporter',
        'C:\\Users\\Tigin_NA\\Documents\\Processing\\py_template\\gifexp\\GifExporter.py')
from gifExporter import gifExport

step = 0;
mX = 300;
mY = 300;
_fRate = 30;

min_x = -20.0
max_x = mX + 90.0


def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(360)
    global gifExp
    gifExp = gifExport(False,verbose=True)   
    

def draw():
    background(360)
    global step
    x = min_x
    '''rotate(radians(45))
    translate(0,-mX/2)'''
    while(x < max_x):
        randomSeed(int(90020*sin(x)))
        sqsize = 3+random(40)
        fill(90000*random(random(360)) % 360,360,360)
        rect(x,mY/2+30*sin(radians(x*3 + step)),sqsize,sqsize)
        x += (sqsize+3)

    gifExp.rec()
    step+=1
