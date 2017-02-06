from pprint import pprint
import imp
'''import Processing lib gifAmimation "http://extrapixel.github.io/gif-animation/"'''
myimp = imp.load_source('gifExporter',
        ''.join([os.environ['USERPROFILE'],
                 '\\Documents\\Processing\\py_template\\gifexp\\GifExporter.py']))
from gifExporter import gifExport
import os

from Cycle import Cycle
#def __init__(self, lng, al, speed=1, x0=None, y0=None, P=None)


step = 0
mX = 400
mY = 400
_fRate = 9000


def analyzer(func, max_period=10**4, compare_len=8, max_err=0.001, *args, **kwargs):
    data = []
    compare_vector = []
    for i in range(compare_len):
        tmpv = func(*args,**kwargs)
        compare_vector += [tmpv]
    data += compare_vector
    for i in range(compare_len,max_period):
        data += [func(*args,**kwargs)]
    def my_little_compare(c1,c2):
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

    minx = min([i[0] for i in data])
    miny = min([i[1] for i in data])
    maxx = max([i[0] for i in data])
    maxy = max([i[1] for i in data])
    return {'period':period,'minx':minx,'maxx':maxx,'miny':miny,'maxy':maxy}
    #print(data)
   
#meta = {}

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(0)
    global gifExp
    gifExp = gifExport(False,verbose=True)  
    global Cyc1
    
    #Конопля
    #Cyc1 = Cycle(55,-1,P=Cycle(35,5,P=Cycle(39,-6)))
    #Домик
    #Cyc1 = Cycle(90,1,P=Cycle(15,-4,P=Cycle(12,3)))
    #Портал
    #Cyc1 = Cycle(90,5,P=Cycle(25,-44,P=Cycle(45,-5)))
    #Привидение
    #Cyc1 = Cycle(10,6,P=Cycle(10,-6,P=Cycle(70,-1)))
    Cyc1 = Cycle(40,-2,
                   [(30,32,
                     (40,-8))])
    global rotating
    rotating = 0
    global meta
    meta = analyzer(Cyc1.get_and_update)
    Cyc1.reset_alpha()
    #Cyc1.reset_alpha()
    #print(meta['period'])
    global print_state
    print_state = 1
    print(meta)
    print(type(analyzer))
    
'''def settings():
    global meta
    size(int((abs(meta['minx'])+abs(meta['maxx']))*1.2),
         int((abs(meta['miny'])+abs(meta['maxy']))*1.2))
'''

def draw():
    translate(width/2,height/2)
    rotate(radians(-90))
    #background(0,0,0,111)
    global step
    global rotating
    speeds = 0.1
    rotate(radians(step*rotating*speeds))
    
    x1,y1 = Cyc1.get_and_update(steps=speeds)
    noStroke()
    global print_state
    fill(210,120,40*print_state)
    sz = 2+(1-print_state)
    #stroke(190,360,90)
    #strokeWeight(0)
    ellipse(x1,y1,sz,sz)
    #Cyc1.update()
    gifExp.rec()
    step+=1
    #if step % int(meta['period']/speeds) == 0:
    #    print(step,meta['period'],'switch')
    #    print_state = (print_state + 1) % 2