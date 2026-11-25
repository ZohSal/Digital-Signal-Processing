# Lab 3 - Frequency-Domain Filtering with fft2

## Reflections

1. Why does ideal LP cause ringing (Gibbs phenomenon)?
Cutting off frequencies sharply in a circle in the frequency domain acts like convolving with a wavy sinc function in space, which creates visible ripple rings around sharp edges in the image.

2. What does fftshift do visually?
fft2 puts the zero-frequency (DC) component at the corners of the matrix. fftshift swaps the quadrants so the DC and low frequencies sit right in the center, while higher frequencies move outward toward the borders.

3. When is frequency-domain filtering computationally preferable?
Since convolution in space becomes simple element-by-element multiplication in the frequency domain, FFT filtering is faster when using large filter kernels (around 15x15 or bigger) where direct spatial convolution gets slow.