from pprint import pprint
from GifExporter import GifExport

step = 0
mX = 300
mY = 300
_fRate = 30
ypos = 0
ypos1 = 0


class lightning:
    def __init__(self):
        pass

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(360)
    global gifExp
    gifExp = GifExport(False,verbose=True)
    

def draw():
    global step
    translate(0, mY/2)
    global ypos, ypos1
    ypos += random(-1, 1) * 5
    fill(360, 360, 360)
    ellipse(step, ypos, 22, 22)
    ypos1 += randomGaussian() * 5
    noStroke()
    fill(220, 360, 360)
    ellipse(step, ypos1, 5, 5)
    fill(360, 0, 360, 25)
    rect(0-1, -mY/2-1, mX+2, mY+2)
    gifExp.rec()
    step+=1
    step %= mX