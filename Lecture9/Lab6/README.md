# Lab 6 - Mini Project: Image Pipeline

## Report

1. Processing pipeline:
Using coins.png, the pipeline loads the grayscale image, removes impulse noise with a 3x3 median filter, stretches the contrast with imadjust, finds thin coin boundaries using Canny edge detection, and also runs a circular low-pass filter in the 2D FFT frequency domain.

2. How each stage relates to DSP operations:
The 3x3 median filter acts as a non-linear rank filter, contrast stretching is a point-wise amplitude remapping, Canny combines Gaussian low-pass smoothing with 2D spatial gradient derivatives, and the circular frequency mask applies ideal low-pass filtering using the 2D Convolution Theorem.

3. Improvements or limitations:
In the frequency-domain step, the sharp circular cutoff (D < 60) causes slight Gibbs ringing around the coin edges, which would look cleaner with a smooth Gaussian low-pass mask instead. Also, if the lighting across the image were uneven, a single global threshold would struggle without background subtraction first.