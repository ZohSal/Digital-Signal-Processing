# Lecture 03 - Discrete-Time Signals, Convolution, and Moving-Average Filtering

## Questions and Answers

### 1. Which operation changed the signal amplitude?
Amplitude scaling (`scaled = 2*measured`) changed the signal amplitude. In `signal_operations.png`, every sample value is doubled, stretching the peaks from roughly +-1.4 up to about +-2.8, while the frequency (number of cycles over the 100 samples) and the horizontal sample positions `n` stayed completely unchanged.

### 2. How did the five-sample delay change the signal?
Adding 5 zeros to the front of the vector (`delayed = [zeros(1,delay) measured]`) shifted the entire waveform 5 sample indices to the right along the `n` axis and increased the total array length from 101 to 106 samples. The shape and amplitude of the signal itself did not change. In a real system, this kind of delay happens because of sensor buffering, analog-to-digital conversion time, or network/cable transmission latency.

### 3. What does the impulse response h[n] represent?
The impulse response `h[n]` defines how the filter weights and combines neighboring input samples to compute each output sample. For a moving-average filter of length `M` (`ones(1,M)/M`), `h[n]` assigns equal weight `1/M` to `M` consecutive samples, acting as a discrete-time low-pass filter that smooths out rapid sample-to-sample jumps.

### 4. How did convolution change the noisy signal?
Using `conv(measured,h5,'same')` replaced each sample with the average of itself and its immediate neighbors. In `noise_filtering.png`, the sharp, jagged random spikes from the additive Gaussian noise are noticeably smoothed out, making the underlying 20-sample-period sine wave much easier to follow.

### 5. What differences did you observe between the 5-point and 15-point filters?
In `filter_comparison.png`, the 5-point filter (`h5`) follows the peaks and valleys of the clean blue sine wave closely while still keeping a small amount of ripple from the noise. The 15-point filter (`h15`) produces a much smoother red dashed curve with almost no jaggedness, but its peaks are visibly flatter and lower than the true sine wave.

### 6. Which filter removed more noise?
The 15-point moving-average filter removed more noise because averaging over 15 samples instead of 5 cancels out more of the positive and negative random fluctuations at each step.

### 7. Did the longer filter remove or distort useful signal information?
Yes. Because the clean sine wave `sin(0.1*pi*n)` completes one full cycle every 20 samples, averaging across 15 samples spans three-quarters of a full wave cycle. In `filter_comparison.png`, this causes clear amplitude attenuation (shrinking the sine wave peaks from +-1.0 down to roughly +-0.65) and blurs the edges at the start and end of the signal due to zero-padding in `'same'` mode.

### 8. Which filter would you recommend for this signal? Explain your decision.
I recommend the 5-point moving-average filter (`h5`) for this signal. Even though it leaves a slight ripple compared to the 15-point filter, it removes most of the random noise while preserving the true +-1.0 amplitude and shape of the sine wave. The 15-point filter distorts the useful signal amplitude too much.

### 9. Give one real engineering application for moving-average filtering.
A practical engineering application is smoothing noisy temperature or ultrasonic distance sensor readings on a microcontroller (such as an ESP32 or STM32), where fast random electrical noise needs to be averaged out before displaying the measurement or feeding it into a control loop.

## AI Usage

Tool used: ChatGPT
How I used it: I used it to check the syntax for padding zeros to create the sample delay and to help organize the subplot colors and legends for the comparison figures.
What I verified or changed: I ran the complete script in MATLAB Online, checked all four generated figures to verify the peak amplitudes and 5-sample horizontal shift, and wrote the observations based on my own plots.