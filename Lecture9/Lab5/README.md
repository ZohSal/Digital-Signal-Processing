# Lab 5 - Edge Detection and Segmentation

## Reflections

1. Which operator gives the thinnest, cleanest edges?
Canny gives the thinnest, cleanest edges because it thins detected edges down to 1-pixel-wide lines using non-maximum suppression.

2. Why does Canny outperform simple gradient filters?
Sobel and Prewitt just take derivatives and apply a single threshold, which leaves thick, noisy edges and breaks faint lines. Canny smooths noise first with a Gaussian filter, thins the ridges to one pixel, and uses two thresholds ([0.05 0.2]) so weak edges connected to strong edges are kept while random noise dots are dropped.

3. How does Otsu relate to histogram-based thresholding?
Otsu's method looks at the pixel intensity histogram and automatically finds the threshold value that best separates the foreground and background peaks by minimizing the variance within each class.