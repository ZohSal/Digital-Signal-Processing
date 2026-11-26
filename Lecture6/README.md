# Lecture 06 - FIR and IIR Digital Filters

## Part A: Sensor Signal Filtering (FIR vs IIR)

### Observations from Plots and Measurements
1. Time-domain comparison (partA_time.png):
The noisy input has fast oscillations from the 50 Hz and 137 Hz interference plus random noise. Both the order-60 FIR filter and the 4th-order Butterworth IIR filter strip away the fast ripples and follow the clean 5 Hz + 12 Hz reference closely, with zero phase shift because filtfilt runs forward and backward.

2. Magnitude responses (partA_freqz.png):
Both filters stay flat near 0 dB across the passband up to the 20 Hz cutoff (around -6 dB at 20 Hz for the FIR design and -3 dB before doubling in filtfilt for the Butterworth IIR). Past 20 Hz, the 4th-order Butterworth IIR drops smoothly and steadily with no passband or stopband ripples, while the order-60 FIR drops steeply around 20 to 35 Hz and then shows stopband ripples below -40 dB.

3. Single-sided amplitude spectra (partA_spectra.png):
- At 5 Hz and 12 Hz: Both peaks (~1.0 at 5 Hz and ~0.35 at 12 Hz) pass through almost untouched in both the FIR and IIR outputs.
- At 50 Hz: The 0.35 interference spike in the noisy spectrum is knocked down almost to zero by both filters.
- At 137 Hz: The 0.20 interference spike is completely removed by both filters.

4. RMSE comparison:
- Noisy Input RMSE: ~0.3765
- FIR Output (Order 60) RMSE: ~0.0566
- IIR Output (Order 4) RMSE: ~0.0558
Both filters cut the RMSE by roughly 85%. RMSE gives a single overall number for how close the filtered waveform is to the clean reference, which is useful for quick comparison, but it cannot tell us whether the remaining error is caused by leftover high-frequency noise, slight attenuation of the 12 Hz component, or edge transients at the start and end of the signal.

5. FIR vs IIR Design Comparison:
- Coefficient/order count: The FIR filter needs order 60 (61 taps), while the Butterworth IIR only needs order 4 (9 total numerator/denominator coefficients) to get similar low-pass performance.
- Transition behavior: The 60-tap FIR transitions sharply near the cutoff with visible stopband lobes, whereas the 4th-order IIR rolls off smoothly with a monotonic response.
- Interference attenuation: Both attenuate 50 Hz and 137 Hz heavily; the 4th-order Butterworth continues dropping deeper at higher frequencies (137 Hz), while the FIR stays bounded by its stopband sidelobes.
- Edge effects: Because filtfilt pads the ends of the finite 2-second signal, slight boundary distortion appears near t = 0 s and t = 2 s, slightly more noticeable on the longer 61-tap FIR impulse response.
- When to prefer each: I would prefer the FIR filter in offline or audio/biomedical applications where exact linear phase (no waveform shape distortion across frequencies) and guaranteed stability are critical. I would prefer the 4th-order IIR filter on an embedded microcontroller with limited CPU and RAM because it achieves strong filtering with far fewer multiplications per sample.

## Part B: 50 Hz Audio Hum Removal

### Observations from Plots and Measurements
1. Waveform comparison (partB_waveform.png):
Adding 0.15*sin(2*pi*50*t) overlays a steady 50 Hz ripple onto the Handel recording. After applying the narrow 49-51 Hz Butterworth band-stop filter with filtfilt, the waveform closely matches the clean reference again.

2. Spectrum and 50 Hz measurement (partB_spectrum.png):
Using the single-sided FFT peak between 49.5 Hz and 50.5 Hz (Fs = 8192 Hz, well above the 102 Hz Nyquist minimum):
- Clean Audio at 50 Hz: ~0.0002 (negligible natural low-end content)
- Hum-Added Audio at 50 Hz: ~0.1500
- Narrow Notch (49-51 Hz) at 50 Hz: ~0.0002 (almost complete removal of the added hum)
- Wider Notch (45-55 Hz) at 50 Hz: ~0.0002

3. Listening and bandwidth trade-off (49-51 Hz vs 45-55 Hz):
With the narrow 49-51 Hz notch filter, the annoying 50 Hz hum disappears while the music sounds practically identical to the clean original. Widening the stop band to 45-55 Hz also removes the 50 Hz hum (and would catch slight frequency drift around 50 Hz), but as seen in partB_spectrum.png, it scoops out a wider chunk of neighboring low frequencies (45 to 55 Hz), which thins out bass notes and low-frequency warmth in music or speech.

## Report Questions

1. Why is a 20 Hz low-pass reasonable for Part A, and what assumption does it make about the wanted sensor signal?
The wanted sensor components are at 5 Hz and 12 Hz, while the unwanted interference starts at 50 Hz and 137 Hz. Putting the cutoff at 20 Hz sits cleanly above 12 Hz so the useful signal passes through, and well below 50 Hz so the interference is blocked. This assumes that the real physical measurement changes slowly and contains no important signal energy above 20 Hz.

2. Which filter gives the better result for the requirements you chose? Support the answer with at least two kinds of evidence.
For an offline sensor measurement where low computational cost and smooth attenuation of high-frequency interference matter, the 4th-order Butterworth IIR filter gives a slightly better overall result. First, numerically, it achieves a slightly lower RMSE (~0.0558 vs ~0.0566 for the FIR filter). Second, in the frequency domain (partA_freqz.png and partA_spectra.png), it provides monotonic roll-off without stopband ripples while using only order 4 instead of 60 taps.

3. How would your implementation change if the sensor had to be filtered live with low latency?
filtfilt cannot be used in a live streaming system because it needs future samples to filter backward. Instead, I would use causal filter(b, a, x) sample-by-sample (or in small buffers) and choose the low-order IIR filter, since an order-60 FIR filter introduces a constant group delay of 30 samples (30 ms at 1000 Hz) and requires 61 multiply-accumulate operations per sample.

4. Why is a narrow band-stop appropriate for a steady 50 Hz hum? What would you do if the interference frequency drifted?
Mains power hum is concentrated right at 50 Hz, so a narrow 49-51 Hz notch removes the interference without damaging surrounding audio frequencies. If the interference frequency drifted over time, a fixed narrow notch would miss it; instead, I would either widen the notch slightly to cover the expected drift range or use an adaptive