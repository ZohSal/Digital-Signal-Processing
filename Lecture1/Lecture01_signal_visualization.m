clear; clc; close all;

% Time vector (1 second duration)
t = 0:0.001:1;

%% Task 1: Create a Sine Wave
y1 = 1 * sin(2*pi*5*t);

figure;
plot(t, y1);
title('5 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% Task 2: Compare Different Frequencies
y_2Hz = sin(2*pi*2*t);
y_5Hz = sin(2*pi*5*t);
y_10Hz = sin(2*pi*10*t);

figure;
subplot(3,1,1);
plot(t, y_2Hz);
title('2 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, y_5Hz);
title('5 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, y_10Hz);
title('10 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

saveas(gcf, 'frequency_comparison.png');

%% Task 3: Compare Different Amplitudes
y_amp05 = 0.5 * sin(2*pi*5*t);
y_amp1 = 1 * sin(2*pi*5*t);
y_amp2 = 2 * sin(2*pi*5*t);

figure;
subplot(3,1,1);
plot(t, y_amp05);
title('Amplitude = 0.5');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2.5 2.5]);
grid on;

subplot(3,1,2);
plot(t, y_amp1);
title('Amplitude = 1');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2.5 2.5]);
grid on;

subplot(3,1,3);
plot(t, y_amp2);
title('Amplitude = 2');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2.5 2.5]);
grid on;

saveas(gcf, 'amplitude_comparison.png');

%% Task 4: Add Noise (Modified from Copilot)
cleanSignal = sin(2*pi*5*t);                     % 5 Hz sine wave
noisySignal = cleanSignal + 0.3*randn(size(t));  % Modified noise scale from 0.5 to 0.3

figure;
subplot(2,1,1);
plot(t, cleanSignal);
title('Clean 5 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2.5 2.5]);                                % Added matching Y-axis limit
grid on;

subplot(2,1,2);
plot(t, noisySignal);
title('Noisy 5 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2.5 2.5]);                                % Added matching Y-axis limit
grid on;

saveas(gcf, 'clean_vs_noisy_signal.png');        % Added save command for Task 5