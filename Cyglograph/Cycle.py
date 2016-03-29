class Cycle:
    def __init__(self, lng, speed=1, al=0, x0=0, y0=0, P=None):
        self.lng = lng
        self.init_al = al
        self.al = al
        self.speed = speed
        self.x0 = x0
        self.y0 = y0
        self.P = P
        self.refresh()

    
    def refresh(self,recursive=True):
        self.x = self.x0 + self.lng * cos(radians(self.al))
        self.y = self.y0 + self.lng * sin(radians(self.al))
        if recursive:
            if isinstance(self.P,Cycle):
                self.P.x0 = self.x
                self.P.y0 = self.y
                self.P.refresh()
                
    def _update_alpha(self,steps=1):
        self.al += self.speed * steps
        if isinstance(self.P,Cycle):
            self.P._update_alpha(steps)
    
    def reset_alpha(self):
        self.al = 0
        self.refresh()
    
    def update(self,steps=1):
        #print(str(self))
        self._update_alpha(steps)
        self.refresh()
        #print(str(self))
        
    def get_coord(self):
        if isinstance(self.P,Cycle):
            return self.P.get_coord()
        else:
            return (self.x,self.y)
        
    def __str__(self):
        if isinstance(self.P,Cycle):
            return  str(self.__dict__)+'\n'+str(self.__dict__['P'])
        else:
            return str(self.__dict__)
    
    def get_and_update(self,steps=1):
        res = self.get_coord()
        self.update(steps)
        return res