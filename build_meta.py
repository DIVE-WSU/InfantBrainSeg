import os
import cPickle
import numpy as np
import Image
import scipy.io
from numpy import loadtxt

def makeBatch( mean_input, label_name_input,  num_cases_per_batch, dimension,save_path):
    
    #text_file1 = open(mean_input, "r")
    #class_list3 = text_file1.read().split(',')
    #mean  = np.float_(class_list3) 
    #mean =  list(mean)
    mean1 = scipy.io.loadmat(mean_input)
    
    mean2 = mean1.values()
    	
    mean3 = mean2[1]
    #return mean3
    #return mean3	
    mean  = np.float_(mean3) 	
    text_file2 = open(label_name_input, "r")
    label_names = text_file2.read().split(',')
	
	
    out_file = open(save_path, 'w+')
 
    dic = {'num_cases_per_batch': num_cases_per_batch,  'label_names': label_names, 'num_vis':dimension,  'data_mean':mean}
    cPickle.dump(dic, out_file)
    #return dic
    out_file.close()