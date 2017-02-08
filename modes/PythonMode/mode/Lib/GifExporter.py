'''
	GifAnimation Processing3 port
	https://github.com/01010101/GifAnimation
'''



add_library('gifAnimation')
from gifAnimation import GifMaker
import sys
import os
import re
import __main__
import datetime

class GifExport:
    def __init__(
                 self,
                 recording = False,
                 path = os.environ['USERPROFILE']+"\\Pictures\\ProcessingResult",
                 name = re.sub('\..*','',__main__.__file__),
                 verbose = False,
				 quality = 10,
				 skip = 0,
				 f_rate = 30
                 ):
        self.__doc__ = """
        Initial args:
            recording  [false]
            path       [\%UserHome\%\\Pictures\\ProcessingResult]
            name       [__main__.__file__]
            verbose    [false]
            quality    [10]
            skip       [0] - skips N frames between records
        
        Usage:
            rec()    - record one frame with delay equal to __main__._fRate
            finish() - huinish
        """
        self.recording = recording
        self.verbose = verbose
        self.f_rate = f_rate
        fpath = ''.join([
                         path,"\\",name,"\\",name,"_",
                         str(datetime.datetime.now().strftime('%Y%m%d_%H%M-%S')),".gif"
                         ])
        self.GM = None
        if(self.recording):
            self.GM = GifMaker(__main__.__papplet__,fpath,1)
            self.GM.setRepeat(0)
            if quality < 1 or quality > 256:
                quality = 10
            self.GM.setQuality(quality)
            self.skip = skip
            self.skip_counter = 0
            if(self.verbose):
                print 'Start record to', fpath
    
    def rec(self):
        if(self.recording):
            if self.skip_counter >= self.skip:
                self.skip_counter = 0
                self.GM.setDelay(max(1, int(1000.0/self.f_rate)))
                self.GM.addFrame()
            else:
                self.skip_counter += 1
    
    def finish(self):
        if(self.recording):
            self.GM.finish()
            self.recording = False
            if(self.verbose):
                print 'Finish record'
				
		
    
    def __del__(self):
        self.finish()
    
