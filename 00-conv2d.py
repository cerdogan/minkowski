#!/usr/bin/env python 
"""
Created on Mon Oct 12 14:56:56 2015

@author: nelaturi
"""
 

#Command line option module
from optparse import OptionParser
#import os
from time import time as now
from pylab import *
from numpy import *
#FFT 2d module  

def vis_data(arr, isVisualize):
    # Plot the cross-correlation 
    #plt.imshow(arr.real,cmap='BuGn') 
    plt.imshow(arr.real)
    plt.show() 
    
def conv_numPy(Y,Z,isCorr):

	#Implement image cross-correlation using numPy FFT routines
	Ysize = array(Y.shape);
	Zsize = array(Z.shape);
	convSize = Ysize + Zsize;
	w = convSize[0]; 
	h = convSize[1] ;

	# Account for wraparound error in the convolution by padding zeros
	im1 = zeros((w,h));
	im1[:Ysize[0],:Ysize[1]] = Y;
	im2 = zeros((w,h));
	if isCorr:
		im2[w-Zsize[0]:, h-Zsize[1]:] = Z;
	else:
		im2[:Zsize[0], :Zsize[1]] = Z;	
	# Compute Fourier Transforms
	im1_ft = fft.fft2(im1);
	im2_ft = fft.fft2(im2);
	print real(im1_ft)
	print real(im2_ft)
	if isCorr:
		im2_ft = im2_ft.conj(); 	# 'Reflect' the shape for correlation
	# Convolution in spatial domain after inverting product of Fourier Transforms in frequency domain
	im_ft = im1_ft * im2_ft;
	print real(im_ft)
	A = fft.ifft2(im_ft); 
	return A   

def make_indicator(X, idx_array):
	# Create an array I of size X (input set), map the indices in idx_array to 1 in I
	I = zeros(array(X.shape))
	I[idx_array] = 1;
	return I	

def measure(arr):
	# Find the epsilon level set of an indicator function and integrate
	# mu(1_X) = volume(X)
	idx = get_sublevel(arr, 1)
	mu = len(idx[0])
	return mu

def get_sublevel(arr, level):
	# Find the indices of sublevel set of a scalar function (particularly convolution) 
	indices = np.nonzero(arr >=(float(level)-0.001))
	return indices

def main():

    # Understand console input
    parser = OptionParser() 
    parser.add_option("-m", default=False, action='store_true', help="Compute Minkowski sum") 
    parser.add_option("-d", default=False, action='store_true', help="Compute Minkowski difference")
    parser.usage = " ./conv.py [options] arg1 arg2"    
    (options, args) = parser.parse_args()
    minkowskiSum = options.m  
    minkowskiDif = options.d
    if len(args)!=2:
        print parser.usage 
        sys.exit("Program requires two input files") 

    print "Convolution of two shapes to extract Minkowski sum or difference"
    X = plt.imread(args[0]) 
    X = 1 * (X[:,:,0] > 0.1) 
    print "X: \n", X
    Y = plt.imread(args[1]) 
    Y = 1 * (Y[:,:,0] > 0.1) 
    print "Y: \n", Y

    # compute the cross-correlation    
    isCorr = False # set this to true if you want to 'reflect' Y e.g. for C-space obstacle
    
    isVisualize = True # set this as an option as above if reqd       

    # compute convolution
    C = conv_numPy(X,Y, isCorr) 
    #print 'hi'
    #vis_data(C,isVisualize)
    
    if minkowskiSum:
        sublevel = get_sublevel(C,1)
        C1 = make_indicator(C,sublevel) 
        print 'sum'
        print "C: \n", np.abs(np.around(C.real, decimals=1))
        #vis_data(C1,isVisualize) 
    if minkowskiDif:
        sublevel = get_sublevel(C,measure(Y))
        C1 = make_indicator(C,sublevel) 
        print 'diff'
        vis_data(C1,isVisualize) 
     
if __name__ == "__main__":
    main()
