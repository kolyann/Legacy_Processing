from pprint import pprint
from GifExporter import GifExport
from Cycle import Cycle
#def __init__(self, lng, speed=1, r_cycle=None, arm_l=0, arm=None, al=0, x0=0, y0=0):


step = 0
mX = 400
mY = 400
_fRate = 120
recording_state = False


def analyzer(func, max_period=10**4, compare_len=8, max_err=0.001, *args, **kwargs):
    data = []
    compare_vector = []
    for i in range(compare_len):
        tmpv = func(*args,**kwargs)
        compare_vector += [tmpv]
    data += compare_vector
    for i in range(compare_len, max_period):
        data += [func(*args,**kwargs)]
    def my_little_compare(c1, c2):
        if abs(c1[0] - c2[0]) <= max_err and abs(c1[1] - c2[1]) <= max_err:
            return True
        return False
    
    period = None
    for i,dt in enumerate(data[compare_len:]):
        i += compare_len
        cmp_res = []
        for j,cmp_elem in enumerate(compare_vector[::-1]):
            cmp_res += [my_little_compare(cmp_elem, data[i-j])]
        if all(cmp_res):
            period = i-compare_len+1
            break    
    
    miny = min([i[0] for i in data])
    minx = min([i[1] for i in data])
    maxy = max([i[0] for i in data])
    maxx = max([i[1] for i in data])
    return {'period':period,'minx':minx,'maxx':maxx,'miny':miny,'maxy':maxy}
    #print(data)
   
meta = {}


def settings():
    global meta
    global Cyc1
    #def __init__(self, lng, speed=1, r_cycle=None, arm_l=0, arm=None, al=0, x0=0, y0=0):
    #Cyc1 = Cycle(120, -2, [(20,-7,[(5,4)]),], 22,[(110,3,[(66,7,None,33,[(55,8)])])],al=180)
    #Cyc1 = Cycle(70,1, [(15,-3)], 20, [(40,5, [(15,-7)])])
    #Cyc1 = Cycle(70, 1, [(30,-1)], 80, [(100, -9, None, 0, None, 0, 200, 0)], x0=-100)
    #Cyc1 = Cycle(40, 1, None, 100, [(40, 1, None, 0, None, 0, -100, 0)], 0, 100, 0)
    Cyc1 = Cycle(0,0,Cycle(80,1, Cycle(80,-1), al=180), 160, Cycle(60,-3,x0=100), x0 = -180)
    meta = analyzer(Cyc1.get_and_update)
#    size(int((abs(meta['minx'])+abs(meta['maxx']))*1.2),
#         int((abs(meta['miny'])+abs(meta['maxy']))*1.2))


def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(0)
    global gifExp
    gifExp = GifExport(recording_state, verbose=True, skip=10) 
    global Cyc1
    #def __init__(self, lng, speed=1, r_cycle=None, arm_l=0, arm=None, al=0, x0=0, y0=0):
    #Cyc1 = Cycle(120, -2, [(20,-7,[(5,4)]),], 22,[(110,3,[(66,7,None,33,[(55,8)])])],al=180)
    #Cyc1 = Cycle(70,1, [(15,-3)], 20, [(40,5, [(15,-7)])])
    #Cyc1 = Cycle(70, 1, [(30,-1)], 80, [(100, -9, None, 0, None, 0, 200, 0)], x0=-100)
    #Cyc1 = Cycle(40, 1, None, 100, [(40, 1, None, 0, None, 0, -100, 0)], 0, 100, 0)
    Cyc1 = Cycle(0,0,Cycle(120,1, Cycle(120,-1), al=180), 160, Cycle(40,-6,x0=200), x0 = -180)
    global rotating
    rotating = 0
    global meta
 
    meta = analyzer(Cyc1.get_and_update)
    Cyc1.reset_alpha()
    
    global print_state
    print_state = 1
    print(meta)


def draw():
    translate(width/2,height/2)
    rotate(radians(-90))
    #background(0,0,0,111)
    global step
    global rotating
    speeds = 0.5
    #rotate(radians(step*rotating*speeds))
    x1,y1 = Cyc1.get_and_update(steps=speeds)
    noStroke()
    global print_state
    sz = 2+(1-print_state)
    #stroke(190,360,90)
    #strokeWeight(0)    
    fill(210,120,200*print_state)
    ellipse(x1,y1,sz,sz)
    gifExp.rec()
    step+=1    
    if step % int(meta['period']/speeds) == 0:
        pass
        print_state *= -1
        print(step,meta['period'],'switch')
        print_state = (print_state + 1) % 2
    if step >= 2*int(meta['period']/speeds):
        gifExp.finish()