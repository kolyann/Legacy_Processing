from pprint import pprint
import imp
myimp = imp.load_source('gifExporter',
        'C:\\Users\\Tigin_NA\\Documents\\Processing\\py_template\\gifexp\\GifExporter.py')
from gifExporter import gifExport


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


    gifExp.rec()
    step+=1
