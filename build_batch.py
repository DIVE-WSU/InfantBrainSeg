import os
import cPickle
import numpy as np
import Image
import scipy.io
from numpy import loadtxt

def makeBatch (load_path, save_path, label_input, name_input):
    data = []
    filenames = []
    #file_list = os.listdir(load_path)
    #return file_list
    file_list2 = open(name_input, "r")
    file_list = file_list2.read().split(',')
    #return file_list	
    for item in file_list:
        #print item
        n = os.path.join(load_path, item)
        #return n
        input = Image.open(n)
        #return input
        arr = np.array(input, order='C')
        #return arr			
        im = np.fliplr(np.rot90(arr, k=3))
        #return im
        data.append(im.T.flatten('C'))
        filenames.append(item)
    data = np.array(data)
    data =  np.float32(data)
    text_file = open(label_input, "r")
    class_list3 = text_file.read().split(',')
    class_list2  = np.int_(class_list3) 
    class_list =  list(class_list2)

    out_file = open(save_path, 'w+')
    flipDat = np.flipud(data)
    rotDat = np.rot90(flipDat, k=3)
    dic = {'batch_label':'training batch 1 of 5', 'data':rotDat, 'labels':class_list, 'filenames':filenames}
    cPickle.dump(dic, out_file)
    #return dic
    out_file.close()
