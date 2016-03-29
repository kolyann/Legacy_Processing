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


step = 0;
mX = 300;
mY = 300;
_fRate = 40;


def analyzer(func, max_period=10**6, compare_len=8, max_err=0.001, *args, **kwargs):
    data = []
    compare_vector = []
    for i in range(compare_len):
        tmpv = func(*args,**kwargs)
        compare_vector += [tmpv]
    
    print(compare_vector)
    
    data += compare_vector
    for i in range(compare_len,max_period):
        data += [func(*args,**kwargs)]

    def my_little_compare(c1,c2):
        if c1[0] - c2[0] <= max_err and c1[1] - c2[1] <= max_err:
            return True
        return False
    
    period = None
    for i,dt in enumerate(data[compare_len:]):
        i += compare_len
        cmp_res = []
        for j,cmp_elem in enumerate(compare_vector[::-1]):
            cmp_res += [my_little_compare(cmp_elem, data[i-j])]
        print(i,cmp_res)
        if all(cmp_res):
            period = i
            print('Period = '+str(i))
            break
    
            
    #print(data)
   

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(0)
    global gifExp
    gifExp = gifExport(False,verbose=True)  
    global Cyc1, Cyc2
    #Cyc1 = Cycle(60,1,P=Cycle(20,-3))
    Cyc1 = Cycle(10,1,P=Cycle(10,-2))
    
    analyzer(Cyc1.get_and_update)
    
    

def draw():
    translate(width/2,height/2)
    rotate(radians(-90))
    #background(0,0,0,111)
    global step
    z = 0
    x1,y1 = Cyc1.get_and_update()
    noStroke()
    fill(190,360,300,90)
    ellipse(x1,y1,5,5)
    #Cyc1.update()
    gifExp.rec()
    step+=1