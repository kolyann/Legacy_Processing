from pprint import pprint
from GifExporter import GifExport

step = 0
mX = 350
mY = 350
_fRate = 45


def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(360)
    global gifExp
    gifExp = GifExport(False, verbose=True)
    

def draw():
    global step
    background(360)
    translate(mX/2, mY/2)
    smooth(5)
    rotate(radians(step))
    le = mouseX
    al = mouseY
    for t in [radians(i)*(360/9) for i in range(1, 10)]:
        draw_byaka(le, -al, t, t*212, 1.2)
    
    
    gifExp.rec()
    if step>=360:
        gifExp.finish()
    step+=1
    
def rec_line(l, a, k):
    if k<=1.01:
        raise Exception("Wrong k parameter")
    try:
        pushMatrix()
        rotate(radians(a))
        strokeWeight(sqrt(l+1))
        stroke(300, 20, 360)
        line(0, 0, l, 0)
        if l>=2:
            translate(l, 0)
            rec_line(l/k, a/k, k)
        popMatrix()
    except:
        pass

def draw_byaka(le, angle, shift, phase, coef, freq=2):
    pushMatrix()
    rotate(shift)
    global step
    f = lambda q, t: sin(radians(step+q)*t)*10
    rec_line(le, angle + f(phase, freq), coef)
    popMatrix()