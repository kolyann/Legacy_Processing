from pprint import pprint
from GifExporter import GifExport

step = 0
mX = 240
mY = 240
_fRate = 72

class square:
    def __init__(self, x, y, sz, cor=0, phase=0, col=color(360)):
        self.x = x
        self.y = y
        self.sz = sz
        self.col = col
        self.cor = cor
        self.phase = phase
        self.xm = x
        self.ym = y
        
    def update(self, stp):
        cum_phase = radians(self.phase + stp)
        if sin(cum_phase)>0 and sin(cum_phase*2)>0:
            self.xm = self.x + sin(cum_phase)*self.sz
        elif sin(cum_phase)<0 and sin(cum_phase*2)>0:
            self.ym = self.y - sin(cum_phase)*self.sz
        else:
            self.x = self.xm
            self.y = self.ym
    
    def draw(self):
        pushMatrix()
        translate(self.xm, self.ym)
        noStroke()
        fill(color(233, 18*3.6, 360-(self.xm + self.ym)/1.7))
        rect(0, 0, self.sz-5, self.sz-5, self.cor, self.cor, self.cor, self.cor)
        popMatrix()

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(360)
    smooth(5)
    global gifExp
    gifExp = GifExport(False, verbose=True, f_rate = _fRate, skip=1, quality=128)

    sz = 60
    corner = 25
    global cells
    cells = [[(x*2, y) if not y%2 else (x*2-1, y) for x in range(-10, 10)] for y in range(-10, 10)]
    cells = [[square(
                     c[0] * sz,
                     c[1] * sz,
                     sz = sz,
                     cor = corner,
                     phase = (c[0]*3 + c[1]*2) * 90,
                     col = color(66, 360, 55)
                     ) for c in row] for row in cells]
    

def draw():
    global step
    translate(0, 0)
    background(233, 360*68/100, 360*61/100)
    rectMode(CENTER)
    global cells
    for row in cells:
        for cell in row:
            cell.update(step)
            cell.draw()
    gifExp.rec()
    if step >= 1440:
        gifExp.finish()
#    if not step%360:
#        saveFrame()
    step+=1
    
def mouseClicked():
    print(frameCount)