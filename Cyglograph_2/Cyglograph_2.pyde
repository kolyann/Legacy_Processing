from pprint import pprint
from GifExporter import GifExport
from Cycle import Cycle
#def __init__(self, lng, speed=1, r_cycle=None, arm_l=0, arm=None, al=0, x0=0, y0=0):


step = 0
mX = 400
mY = 400
_fRate = 180
rotating = 0
speeds = 0.4
base_record_steps_skip = 5
record_steps_skip = int(base_record_steps_skip / (speeds/0.25))
scaling = True
recording_state = False


def analyzer(func, max_period=3700, compare_len=8, max_err=0.01, *args, **kwargs):
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
    
def calculate_scale_coff(meta_vals):
    x_width = meta['maxx'] - meta['minx']
    y_height = meta['maxy'] - meta['miny']
    
    x_center = (meta['maxx'] + meta['minx'])/2
    y_center = (meta['maxy'] + meta['miny'])/2
    trans_value = (x_center, y_center)
    
    lim_coef = 0.9
    scale_coeff = 0
    if (lim_coef < x_width/mX < 1) or (lim_coef < y_height / mY < 1):
        scale_coeff = 1
    else:
        scale_coeff = lim_coef/max(x_width/mX, y_height/mY)
    base_multiplier = 0.85
    scale_coeff = base_multiplier*scale_coeff if scale_coeff * meta['maxx'] > mX/2 else scale_coeff
    scale_coeff = base_multiplier*scale_coeff if scale_coeff * meta['minx'] < -mX/2 else scale_coeff
    scale_coeff = base_multiplier*scale_coeff if scale_coeff * meta['maxy'] > mY/2 else scale_coeff
    scale_coeff = base_multiplier*scale_coeff if scale_coeff * meta['miny'] < mY/2 else scale_coeff
    
    return (scale_coeff, trans_value)               
                         
meta = {}


def settings():
    global meta
    global Cyc1
    #def __init__(self, lng, speed=1, r_cycle=None, arm_l=0, arm=None, al=0, x0=0, y0=0):
    #Cyc1 = Cycle(120, -2, [(20,-7,[(5,4)]),], 22,[(110,3,[(66,7,None,33,[(55,8)])])],al=180)
    #Cyc1 = Cycle(70,1, [(15,-3)], 20, [(40,5, [(15,-7)])])
    #Cyc1 = Cycle(130, 1, [(30,-1)], 40, [(120, -7, None, 0, None, 0, 120, 0)])
    #Cyc1 = Cycle(40, 1, None, 100, [(40, 1, None, 0, None, 0, -100, 0)], 0, 100, 0)
    #Cyc1 = Cycle(0,0,Cycle(80,1, Cycle(80,-1), al=180), 160, Cycle(60,-3,x0=100), x0 = -180)
    #Cyc1 = Cycle(160, 1, [(30, -15, None)], 100, [(40, -3)])
    
    #Risuem huy
    #Cyc1 = Cycle(100, 1, [(40, -1)])     #Oval
    #Cyc1 = Cycle(30, 2, [(100, -1, [(30, -2, [(-30, -2, None, 0, None, 180)])], 60)])
    #Cyc1 =  Cycle(100, 2, [(50, -2, Cycle(30, 2, [(30, -2, None, 0, None, )], 0, None, 180))])
    
    #Poluchilsya Bonifaciy
    #Cyc1 = Cycle(60, 2, [(40, 3, [(20, 4, [(10, -5)])], 40, [(10, 1)], 180)])
    #Oslik IA
    #Cyc1 = Cycle(60, -1, [(40, -3, [(30, 4, [(10, -5)])], 40, [(25, -3)], 180)])
    #KROLIK
    #Cyc1 = Cycle(105, -1, [(20, -3, [(28, 6, [(13, -2, [(40, 1)])], 30, [(50, 4, [(20, -3, [(28, 6, [(13, -2, [(40, 1)])], 30, [(50, 4)])], 85, [(35, -3, [(-30, 2)], 40, [(90, -2)])], 180)])])], 85, [(35, -3, [(-30, 2, [(20, -3, [(28, 6, [(13, -2, [(40, 1)])], 30, [(50, 4)])], 85, [(35, -3, [(-30, 2)], 40, [(90, -2)])], 180)])], 40, [(90, -2)])], 180)])
    
    #WJIEM
    #Cyc1 = Cycle(100, -1, [(50, -2, [(80, -2, None, 80, [(20, -3)])], 0, None, 180)], 20, [(60, 1, [(40, -7, None, 120, [(200, 3)])])])
    
    #Cyc1 = Cycle(60, -8, [(70, 1, [(20, 16)])], 20, [(100, -8, [(36, 1, None, 55, [(0, 0)], 180)], 0, None, 90)])
    Cyc1 = Cycle(160, -1, [(20, 2, [(10, -9, [], 0, None, 180)], 0, None, 0)])
    
    
    #Risuem pizdu
    '''
    Cyc1 = Cycle(100, 3, [(65, -3, [(9, 2, [(15, -1, [(15, -1, [(1, 72)])], 0, None, -540)], 20, None, 180)])], 0, None, 0)
    '''
   
    #def __init__(self, lng, speed=1, r_cycle=None, arm_l=0, arm=None, al=0, x0=0, y0=0):
    meta = analyzer(Cyc1.get_and_update)
#    size(int((abs(meta['minx'])+abs(meta['maxx']))*1.2),
#         int((abs(meta['miny'])+abs(meta['maxy']))*1.2))


def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(0)
    global gifExp
    global record_steps_skip
    gifExp = GifExport(recording_state, verbose=True, skip=record_steps_skip) 

    global meta
    meta = analyzer(Cyc1.get_and_update)
    Cyc1.reset_alpha()
    
    global print_state
    print_state = 1
    print(meta)
    
    global scale_coeff, trans_coeff 
    (scale_coeff, trans_coeff) = calculate_scale_coff(meta)
    print('Scale coefficient: {0}\nTranslate coords: {1}'.format(scale_coeff, trans_coeff))


def draw():
    translate(width/2,height/2)
    translate(*trans_coeff)
    scale(scale_coeff)
    rotate(radians(-90))
    #background(0,0,0,111)
    global step
    global rotating
    global speeds
    rotate(radians(step*rotating*speeds))
    x1,y1 = Cyc1.get_and_update(steps=speeds)
    noStroke()
    global print_state
    sz = 2
    if scale_coeff > 2:
        sz /= (scale_coeff/2)
    #stroke(190,360,90)
    #strokeWeight(0)    
    if print_state > 0:
        fill(213,160,260)
        ellipse(x1,y1,sz,sz)
    gifExp.rec()
    step+=1    
    if step % int(meta['period']/speeds) == 0:
        print_state *= -1
        #print(step,meta['period'],'switch')
        #print_state = (print_state + 1) % 2
    if step >= 2*int(meta['period']/speeds):
        gifExp.finish()