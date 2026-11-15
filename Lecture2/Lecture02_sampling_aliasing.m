clear; clc; close all;

% Task 1: Original 10 Hz signal (using 1000 Hz step so it looks smooth)
f = 10;
t = 0:0.001:1;
y = sin(2*pi*f*t);

f1 = figure(1);
plot(t, y);
title('Original 10 Hz Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Signal');
grid on;
exportgraphics(f1, 'original_signal.png');

% Task 2: Sampling at different frequencies

% 15 Hz
fs1 = 15;
t1 = 0:1/fs1:1;
y1 = sin(2*pi*f*t1);

f2 = figure(2);
plot(t, y, 'b');
hold on;
plot(t1, y1, 'ro--');
hold off;
title('Sampling at 15 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original 10 Hz', 'Sampled 15 Hz');
grid on;
exportgraphics(f2, 'sampling_15Hz.png');

% 20 Hz
fs2 = 20;
t2 = 0:1/fs2:1;
y2 = sin(2*pi*f*t2);

f3 = figure(3);
plot(t, y, 'b');
hold on;
plot(t2, y2, 'ro--');
hold off;
title('Sampling at 20 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original 10 Hz', 'Sampled 20 Hz');
grid on;
exportgraphics(f3, 'sampling_20Hz.png');

% 25 Hz
fs3 = 25;
t3 = 0:1/fs3:1;
y3 = sin(2*pi*f*t3);

f4 = figure(4);
plot(t, y, 'b');
hold on;
plot(t3, y3, 'ro--');
hold off;
title('Sampling at 25 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original 10 Hz', 'Sampled 25 Hz');
grid on;
exportgraphics(f4, 'sampling_25Hz.png');

% 50 Hz
fs4 = 50;
t4 = 0:1/fs4:1;
y4 = sin(2*pi*f*t4);

f5 = figure(5);
plot(t, y, 'b');
hold on;
plot(t4, y4, 'ro--');
hold off;
title('Sampling at 50 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original 10 Hz', 'Sampled 50 Hz');
grid on;
exportgraphics(f5, 'sampling_50Hz.png');

% 100 Hz
fs5 = 100;
t5 = 0:1/fs5:1;
y5 = sin(2*pi*f*t5);

f6 = figure(6);
plot(t, y, 'b');
hold on;
plot(t5, y5, 'ro--');
hold off;
title('Sampling at 100 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original 10 Hz', 'Sampled 100 Hz');
grid on;
exportgraphics(f6, 'sampling_100Hz.png');