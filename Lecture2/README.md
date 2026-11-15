# Lecture 02 – Sampling and Aliasing

## Objective
The purpose of this assignment is to test how different sampling frequencies (15, 20, 25, 50, and 100 Hz) affect a 10 Hz vibration signal when converting it to digital samples, and figure out which rate makes the most sense for a real system without getting aliasing.

## Nyquist Analysis
Original signal frequency:
fmax = 10 Hz

Calculation using the Nyquist theorem:
fs_min = 2 * fmax
fs_min = 2 * 10 Hz = 20 Hz

So the minimum sampling frequency is 20 Hz.

1. Which sampling frequencies satisfy the Nyquist criterion?  
20 Hz, 25 Hz, 50 Hz, and 100 Hz are all at or above 20 Hz.

2. Is sampling exactly at the Nyquist rate recommended in practice? Explain your answer.  
No, definitely not. When I plotted the 20 Hz one, all the sample points landed right where the sine wave crosses 0, so the sampled signal just turned into a flat line at 0. In a real system you always want to sample higher than the bare minimum so you don't lose the peaks of the wave.

## Results
- 15 Hz: Way too slow. Connecting the red sample dots makes it look like a slower 5 Hz wave instead of 10 Hz because it misses half the cycles.
- 20 Hz: Every sample hits right on 0 amplitude (at 0, 0.05s, 0.1s, etc.), so it just looks like a flat line with no signal at all.
- 25 Hz: You can tell there are 10 waves now, but the shape is super blocky and the height of the peaks keeps shrinking and growing.
- 50 Hz: Looks pretty good. There are 5 samples per wave cycle so it follows the original 10 Hz wave nicely, even if the corners are still a bit sharp.
- 100 Hz: Looks almost identical to the smooth original wave since there are 10 sample points on every single cycle.

## Aliasing Discussion
Aliasing happens at 15 Hz (and at 20 Hz we get complete signal loss because of where the samples land). Aliasing occurs because 15 Hz is below the 20 Hz Nyquist limit, meaning we are taking fewer than 2 samples per wave cycle. Because the sensor isn't checking the signal fast enough, the points jump across different cycles and create a fake 5 Hz wave pattern.

For a real engineering system, I would recommend 50 Hz. It is accurate enough to clearly capture all 10 cycles and the peak amplitudes without any aliasing, unlike 25 Hz which still looks really distorted. At the same time, 50 Hz only collects half as many data points as 100 Hz, so it saves memory and processing power on the monitoring hardware while still giving a safe margin above the 20 Hz limit.

## AI Usage
- AI Tool Used:  
ChatGPT

- Prompt(s):  
How do I plot a 10 Hz continuous sine wave in MATLAB and overlay a sampled version at 15 Hz on the same graph?

- Summary of AI Response:  
ChatGPT gave me code using `t = 0:0.001:1` for the main wave and `t_sampled = 0:1/15:1` for the 15 Hz one. It used `hold on` and `stem(t_sampled, y_sampled)` to draw vertical lines for the sample points on top of the sine wave.

- What I Modified:  
I changed `stem` to `plot(t1, y1, 'ro--')` so that the red circles are connected with a dashed line. With `stem` it was kind of hard to see the fake aliased wave shape at 15 Hz, but connecting the dots with `ro--` made the 5 Hz alias and the flat line at 20 Hz way easier to see. I also repeated the block for the other frequencies (20, 25, 50, 100 Hz) and used `exportgraphics` to save all the png files properly.

- How I Verified the Results:  
I ran the script and checked each plot. For 15 Hz I counted 5 full waves in 1 second on the red dashed line (which matches 15 - 10 = 5 Hz alias), saw the flat zero line at 20 Hz, and checked that 50 Hz and 100 Hz lined up with all 10 cycles of the blue wave.