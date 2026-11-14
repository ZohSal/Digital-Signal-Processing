# Lecture 1

### Task 2: Compare Different Frequencies

1. Which signal changes fastest?  
10 Hz

2. Which signal has the lowest frequency?  
2 Hz

3. How can you see the difference in the plots?  
The 10 Hz plot has way more waves packed into the 1 second timeframe (10 full cycles), while the 2 Hz one is stretched out and only goes up and down twice.

### Task 3: Compare Different Amplitudes

1. Which signal has the largest amplitude?  
The one with amplitude = 2.

2. Does changing amplitude change frequency?  
No, frequency stays the same. All three still do 5 cycles in 1 second, only the vertical height changes.

3. Give one real-world example where amplitude is important.  
Audio volume - higher amplitude means louder sound, while frequency is the pitch.

### Task 4: Add Noise

1. What changed after adding noise?  
The line went from being a smooth curve to looking super jagged and shaky because of the random values added to every point.

2. Can you still recognize the original signal?  
Yeah, you can still see the main 5 Hz wave shape going up and down underneath the noise.

3. Give one real-world source of signal noise.  
Static or interference on a microphone cable.

### Task 6: Use AI Responsibly

AI Tool Used:  
MATLAB Copilot

Prompt:  
How do I generate a 5 Hz sine wave and add random noise to it in MATLAB, then plot the clean and noisy signals using subplots?

What AI Suggested:  
Use sin for the clean 5 Hz wave, add Gaussian noise with randn, and plot both with subplot.

matlab
t = 0:0.001:1;                 % Time vector
cleanSignal = sin(2*pi*5*t);   % 5 Hz sine wave
noisySignal = cleanSignal + 0.5*randn(size(t));  % Add noise

figure;
subplot(2,1,1);
plot(t, cleanSignal);
title('Clean 5 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, noisySignal);
title('Noisy 5 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

If you want, you can also save the figure with saveas(gcf,'clean_vs_noisy_signal.png').

Did the code work immediately?  
Yes, it ran fine without any errors.

What did you modify?  
I lowered the noise multiplier from 0.5 to 0.3 so the sine wave wasn't as buried in the noise. I also added ylim([-2.5 2.5]) to both subplots so they had the same y-axis scale, and added the saveas line at the bottom to save the png.

How did you verify the result?  
Ran the script and checked the plots to make sure there were 5 waves in 1 second, the y-axis limits matched on both plots, and the png saved properly in my folder.