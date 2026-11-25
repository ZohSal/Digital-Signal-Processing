# Lab 1 - Image as a 2D Signal

## Reflections

1. Relate bit-depth to visible banding/posterization you observed:
Going from 8-bit down to ~6-bit and ~4-bit cuts the number of gray levels from 256 down to 64 and 16. Because nearby pixel values get rounded into bigger steps, smooth areas like the peppers break into flat color bands (posterization) instead of blending smoothly.

2. How does contrast stretching change the histogram and visibility of details?
Stretching [0.2, 0.8] to [0, 1] spreads the pixel values across the full 0 to 255 range on the histogram. Dark areas become darker and bright areas become brighter, which makes small details and textures in the middle tones much easier to see.

3. Explain why aggressive downsampling causes aliasing (reference Nyquist):
Downsampling to 10% with nearest-neighbor skips most of the pixels without smoothing the image first. Because the sampling rate drops way below the Nyquist limit for the fine details in the image, high-frequency textures fold back into the upscaled image as blocky, jagged aliasing artifacts.