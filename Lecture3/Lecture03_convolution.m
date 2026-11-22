clear;
close all;
clc;

rng(1);

n = 0:100;
clean = sin(0.1*pi*n);

noise = 0.4*randn(size(n));
measured = clean + noise;

figure;
plot(n,clean,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Clean and Noisy Signals');
legend('Clean Signal','Noisy Signal');

%% Task 1: Amplitude Scaling
scaled = 2*measured;

figure;
plot(n,measured,'Color',[0.6 0.6 0.6]);
hold on;
plot(n,scaled,'r','LineWidth',1.2);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Amplitude Scaling');
legend('Noisy Signal','Scaled Signal');
saveas(gcf,'signal_operations.png');

%% Task 2: Signal Delay
delay = 5;
delayed = [zeros(1,delay) measured];

n_measured = 0:length(measured)-1;
n_delayed = 0:length(delayed)-1;

figure;
plot(n_measured,measured,'Color',[0.6 0.6 0.6]);
hold on;
plot(n_delayed,delayed,'m','LineWidth',1.2);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Signal Delay');
legend('Noisy Signal','Delayed Signal');

%% Task 3: Five-Point Moving-Average Filter
h5 = ones(1,5)/5;
filtered5 = conv(measured,h5,'same');

figure;
plot(n,clean,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);
plot(n,filtered5,'g','LineWidth',1.5);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Five-Point Moving-Average Filter');
legend('Clean Signal','Noisy Signal','5-Point Filtered');
saveas(gcf,'noise_filtering.png');

%% Task 4: Compare Two Filter Lengths
h15 = ones(1,15)/15;
filtered15 = conv(measured,h15,'same');

figure;
plot(n,clean,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);
plot(n,filtered5,'g','LineWidth',1.5);
plot(n,filtered15,'r--','LineWidth',1.5);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('5-Point vs 15-Point Moving-Average Filter');
legend('Clean Signal','Noisy Signal','5-Point Filtered','15-Point Filtered');
saveas(gcf,'filter_comparison.png');