from pprint import pprint
import imp
'''import Processing lib gifAmimation "http://extrapixel.github.io/gif-animation/"'''
myimp = imp.load_source('gifExporter',
        ''.join([os.environ['USERPROFILE'],
                 '\\Documents\\Processing\\py_template\\gifexp\\GifExporter.py']))
from gifExporter import gifExport
import os


step = 0;
mX = 400;
mY = 300;
_fRate = 30;

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(360)
    global gifExp
    gifExp = gifExport(False,verbose=True)   


def draw():
    global step
    background(360)
    
    _x0 = 50
    _x1 = 250
    _y = 250
    wdth = 50
    amnt = 7
    lng = 100
    
    for ln in range(amnt):
        tx0 = _x0 + ln*wdth
        stroke(330)
        line(tx0,_y,tx0,_y/2)
        stroke(0)
        line(tx0,_y,mouseX,mouseY)
        angle = degrees(atan2(tx0 - mouseX,_y - mouseY))
        #print(angle)   
        k = norm(ln,amnt/2,amnt)
        #print(k)
        #k = -1
        gamma = myalfa(angle,k)
        #print('alfa =',angle)
        #print('beta =',90 - angle)
        #print('gamma =',gamma)
        tx1 = tx0 + sin(radians(gamma))*lng
        _y1 = _y - cos(radians(gamma))*lng
        line(tx0,_y,tx1,_y1)
        line(tx1,_y1,mouseX,mouseY)
        
    gifExp.rec()
    step+=1
    
def myalfa(alfa,k):
    return 45*max(k,0) + alfa/(abs(k)+1) + 45*min(k,0)
