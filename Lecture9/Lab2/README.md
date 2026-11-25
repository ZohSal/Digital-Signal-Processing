# Lab 2 - 2D Convolution & FIR Filters

## Reflections

1. Why is Gaussian preferred over large box LP?
A large box filter has sharp edges, which creates ringing ripples in the frequency domain and makes the blur look blocky. A Gaussian filter tapers down smoothly in both space and frequency, so it blurs the image evenly without harsh artifacts.

2. What does separability do for computational cost?
Instead of doing a 2D N x N multiplication for every pixel (N^2 operations), a separable filter like the Gaussian splits into two 1D passes (horizontal then vertical). That drops the math down to 2N operations per pixel, so a 7x7 filter takes 14 multiplications instead of 49.

3. How do boundary modes change corners/edges?
Replicate repeats the outer edge pixels so the border looks normal, symmetric mirrors the image across the edge for a smooth transition, and circular wraps pixels from the opposite side of the image around, which can bleed bright or dark parts from the other side onto the edges.