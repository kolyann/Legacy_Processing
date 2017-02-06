
class Tailed:
    def __init__(self, func, **kwargs):
        self.func = func
        self.lng = kwargs.get('lng',10)
        self.history = [None for i in range(self.lng)]
    
    def remember(self, func, *args):
        self.history.pop(0)
        self.history.append((func,args))
        if len(self.history) > 2:
            if self.history[-1] == self.history[-2]:
                print('nulling')
                self.history[-2] = None
    
    def drw(self, *args):
        for i in self.history:
            if not i:
                continue
            #print(i[1])
            self.func(*i[1])
        self.remember(self.func,*args)
        self.func(*args)
