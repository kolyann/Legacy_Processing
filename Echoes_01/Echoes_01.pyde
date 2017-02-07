from pprint import pprint
from GifExporter import GifExport
from tailed_fig import Tailed


step = 0
mX = 300
mY = 300
_fRate = 30

def setup():
    #print(dir(tailed_fig))
    global T, F
    T = Tailed(ellipse, lng=1)
    #F = Tailed(rect,30,30,50,60)
    size(mX, mY)
    colorMode(HSB, 360)
    frameRate(_fRate)
    background(360)
    global gifExp
    gifExp = GifExport(False, verbose=True)


def draw():
    global step
    background(360)
    T.drw(mouseX,mouseY,40,80)
    #F.drw()
    gifExp.rec()
    step += 1