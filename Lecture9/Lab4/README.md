# Lab 4 - Noise and Filtering

## Reflections

1. Which noise is best removed by median filter? Why?
Salt-and-pepper noise is best removed by the median filter. Salt-and-pepper adds extreme black (0) or white (1) outlier pixels, and sorting a 3x3 window to pick the middle value completely ignores those extreme spikes instead of averaging them into nearby pixels.

2. Why does linear filtering blur edges more?
Average and Gaussian filters take a weighted average of every pixel inside the window, so sharp edges between objects and the background get mixed together and smeared out.

3. How could we design adaptive filters to preserve detail?
An adaptive filter can check the local variance inside each window first. In flat areas with low variance (mostly noise), it applies strong smoothing, while near edges with high variance, it reduces smoothing so sharp details stay intact.