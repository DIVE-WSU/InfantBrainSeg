import numpy as np

def unpickle(file):
    import cPickle
    fo = open(file, 'rb')
    dict = cPickle.load(fo)
    aa = dict.values()
    bb = aa[3]

    cc = list(bb)
    #dd  = np.float_(cc) 	
    fo.close()
    return dict