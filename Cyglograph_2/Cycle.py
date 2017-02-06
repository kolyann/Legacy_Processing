from collections import OrderedDict

def get_arm_coords(x0,y0,x1,y1,L):
    t_angle = ((atan2(x0-x1, y0-y1))+PI/2)%(2*PI)
    fin_x = x0 + L * cos(-t_angle)
    fin_y = y0 + L * sin(-t_angle)
    return (fin_x, fin_y)

class Cycle:
    def __init__(self, lng, speed=1, r_cycle=None, arm_l=0, arm=None, al=0, y0=0, x0=0):
        self.lng = lng
        self.init_al = al
        self.al = al
        self.speed = speed
        self.x0 = x0
        self.y0 = y0
        self.arm = arm
        self.arm_l = arm_l
        #self.init_args = locals()
        
        if isinstance(r_cycle,list):
            pargs = r_cycle[0]
            pkwargs = {}
            if len(r_cycle) > 1:
                pkwargs = r_cycle[1]
            self.r_cycle = Cycle(*pargs,**pkwargs)
        else:
            self.r_cycle = r_cycle
        
        if isinstance(arm, list):
            a_args = arm[0]
            a_kwargs = {}
            if len(arm) > 1:
                a_kwargs = arm[1]
            self.arm = Cycle(*a_args, **a_kwargs)
        else:
            self.arm = arm    
            
        self.refresh()

    
    def refresh(self,recursive=True):
        self.x = self.x0 + self.lng * cos(radians(self.al))
        self.y = self.y0 + self.lng * sin(radians(self.al))
        
        if self.arm:
            self.arm.refresh()
        
        if recursive:
            if self.r_cycle:
                self.r_cycle.x0 = self.x
                self.r_cycle.y0 = self.y
                self.r_cycle.refresh()
                
    def _update_alpha(self,steps=1):
        self.al += self.speed * steps
        if isinstance(self.r_cycle,Cycle):
            self.r_cycle._update_alpha(steps)
        if self.arm:
            self.arm._update_alpha(steps)
    
    def reset_alpha(self):
        self.al = self.init_al
        if isinstance(self.r_cycle,Cycle):
            self.r_cycle.reset_alpha()
        if self.arm:
            self.arm.reset_alpha()        
        self.refresh()
    
    def update(self,steps=1):
        #print(str(self))
        self._update_alpha(steps)
        self.refresh()
        #print(str(self))
        
    def get_coord(self):
        t_coord = None
        if isinstance(self.r_cycle,Cycle):
            t_coord = self.r_cycle.get_coord()
        else:
            t_coord = (self.x,self.y)
        if self.arm:
            arm_coord = self.arm.get_coord()
            return get_arm_coords(t_coord[0],t_coord[1], arm_coord[0], arm_coord[1], self.arm_l)
        return t_coord
            
        
    def __str__(self):
        dct = (OrderedDict(self.__dict__))
        res = str(dct)
        if isinstance(self.r_cycle,Cycle):
            res = res+'\nR:'+str(self.__dict__['r_cycle'])
        if self.arm:
            res = res+'\nA:'+str(self.__dict__['arm'])
        return res
    
    def get_and_update(self,steps=1):
        res = self.get_coord()
        self.update(steps)
        return res