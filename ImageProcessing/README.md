# Image Processing Assignment - Option A: Compare Denoising Filters

## Selected Option
Option A - Compare denoising filters

## Image and Settings
- Reference image: rice.png (MATLAB built-in sample image, 256x256 grayscale)
- Degradation settings: rng(42), Gaussian noise (mean = 0, variance = 0.01) followed by salt & pepper noise (density = 0.02)
- Filters tested:
  1. 3x3 median filter (medfilt2)
  2. Gaussian filter with sigma = 1.5 (imgaussfilt)
  3. 3x3 median filter followed by Gaussian filter with sigma = 1
- Zoomed region: 70x70 pixels (rows 80:149, columns 80:149)
- MATLAB Version: R2026a (MATLAB Online with Image Processing Toolbox)

## How to Run the Live Script
1. Open analysis.mlx in MATLAB (with the Image Processing Toolbox installed).
2. Make sure there is a folder named results/ in the same directory as analysis.mlx.
3. Click Run in the Live Editor tab to create the degraded image, apply all three filters, display the PSNR/SSIM table and zoomed montages, and save the output files into results/.

## Main Conclusion
The combined 3x3 median + Gaussian (sigma = 1) filter works best for mixed Gaussian and salt-and-pepper noise, giving the highest PSNR and SSIM scores. A median filter alone removes the salt-and-pepper dots well while keeping the grain edges sharp, but leaves Gaussian background graininess behind. A Gaussian filter alone blurs the salt-and-pepper dots into grey smudges. Doing the median filter first removes the spikes cleanly before the mild Gaussian filter smooths out the remaining background noise.

## Limitation
PSNR and SSIM require a clean reference image (Iref) to compare against, which is not available in real-world imaging. Also, PSNR and SSIM only measure pixel and structural similarity rather than checking if a later step, like segmenting or counting the rice grains, actually works better.

## Use of AI Assistance
I used ChatGPT to help write the MATLAB code for building the PSNR/SSIM results table and setting up the 70x70 zoomed crop with montage, since I am not super confident with MATLAB plotting syntax. I ran the Live Script myself in MATLAB Online, checked the PSNR and SSIM values in the table, and looked at the zoomed rice grains myself to write the comparison and limitations.