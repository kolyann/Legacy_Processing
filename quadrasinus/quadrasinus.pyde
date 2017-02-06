from pprint import pprint
import imp
myimp = imp.load_source('gifExporter',
        'C:\\Users\\Tigin_NA\\Documents\\Processing\\py_template\\gifexp\\GifExporter.py')
from gifExporter import gifExport

step = 0;
mX = 400;
mY = 200;
_fRate = 30;

min_x = -20.0
max_x = mX + 90.0
init_seed = int(random(0,999999))

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(360)
    global gifExp
    gifExp = gifExport(True,verbose=True)   
    print(init_seed)
    

def draw():
    background(360)
    global step
    x = min_x
    '''rotate(radians(45))
    translate(0,-mX/2)'''
    while(x < max_x):
        randomSeed(int(init_seed*sin(x)))
        sqsize = 3+random(40)
        fill(random(0,360) % 360,360,360)
        strokeWeight(0)
        rect(x,mY/2+30*(sin(radians(x*3 + step))+(random(0,x)%2.0)*cos(x)-(random(-10,x)%1.5)*sin(x*2)),sqsize,sqsize)
        x += (sqsize+3)

    gifExp.rec()
    step+=3
    if(step >= 360):
        gifExp.finish()
    
