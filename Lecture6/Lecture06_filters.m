clear; close all; clc;

%% Part A: Sensor Signal Filtering
Fs = 1000;
t = (0:1/Fs:2-1/Fs)';
rng(7);
clean = sin(2*pi*5*t) + 0.35*sin(2*pi*12*t);
noise = 0.35*sin(2*pi*50*t) + 0.20*sin(2*pi*137*t) + 0.25*randn(size(t));
x = clean + noise;

fc = 20;
bFIR = fir1(60, fc/(Fs/2), 'low');
[bIIR, aIIR] = butter(4, fc/(Fs/2), 'low');
yFIR = filtfilt(bFIR, 1, x);
yIIR = filtfilt(bIIR, aIIR, x);

idx = t <= 0.2;
figure;
plot(t(idx), x(idx), 'Color', [0.7 0.7 0.7]); hold on;
plot(t(idx), clean(idx), 'k', 'LineWidth', 1.5);
plot(t(idx), yFIR(idx), 'b--', 'LineWidth', 1.3);
plot(t(idx), yIIR(idx), 'r:', 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Sensor Signal Comparison (0 to 0.2 s)');
legend('Noisy Input', 'Clean Reference', 'FIR (Order 60)', 'IIR Butterworth (Order 4)');
saveas(gcf, 'partA_time.png');

[H_fir, f_resp] = freqz(bFIR, 1, 2048, Fs);
[H_iir, ~] = freqz(bIIR, aIIR, 2048, Fs);

figure;
plot(f_resp, 20*log10(abs(H_fir) + eps), 'b', 'LineWidth', 1.4); hold on;
plot(f_resp, 20*log10(abs(H_iir) + eps), 'r--', 'LineWidth', 1.4);
xline(20, 'k--', '20 Hz Cutoff');
xlim([0 200]);
ylim([-100 5]);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response: FIR vs Butterworth IIR');
legend('FIR (Order 60)', 'IIR Butterworth (Order 4)', 'Location', 'southwest');
saveas(gcf, 'partA_freqz.png');

N = length(x);
f_fft = Fs*(0:(N/2))/N;

P_noisy = abs(fft(x)/N);
P1_noisy = P_noisy(1:N/2+1);
P1_noisy(2:end-1) = 2*P1_noisy(2:end-1);

P_fir = abs(fft(yFIR)/N);
P1_fir = P_fir(1:N/2+1);
P1_fir(2:end-1) = 2*P1_fir(2:end-1);

P_iir = abs(fft(yIIR)/N);
P1_iir = P_iir(1:N/2+1);
P1_iir(2:end-1) = 2*P1_iir(2:end-1);

figure;
plot(f_fft, P1_noisy, 'Color', [0.65 0.65 0.65], 'LineWidth', 1.2); hold on;
plot(f_fft, P1_fir, 'b', 'LineWidth', 1.3);
plot(f_fft, P1_iir, 'r--', 'LineWidth', 1.3);
xlim([0 160]);
grid on;
xlabel('Frequency (Hz)');
ylabel('Single-Sided Amplitude');
title('Single-Sided Amplitude Spectra');
legend('Noisy Input', 'FIR Output', 'IIR Output');
saveas(gcf, 'partA_spectra.png');

rmse_noisy = sqrt(mean((x - clean).^2));
rmse_fir = sqrt(mean((yFIR - clean).^2));
rmse_iir = sqrt(mean((yIIR - clean).^2));

fprintf('Noisy RMSE: %.4f\n', rmse_noisy);
fprintf('FIR RMSE: %.4f\n', rmse_fir);
fprintf('IIR RMSE: %.4f\n\n', rmse_iir);

%% Part B: 50 Hz Audio Hum Removal
load handel
xClean = y(:);
tAudio = (0:numel(xClean)-1)'/Fs;
xHum = xClean + 0.15*sin(2*pi*50*tAudio);

[bN, aN] = butter(2, [49 51]/(Fs/2), 'stop');
[bWide, aWide] = butter(2, [45 55]/(Fs/2), 'stop');

yAudio = filtfilt(bN, aN, xHum);
yAudioWide = filtfilt(bWide, aWide, xHum);

idxA = (tAudio >= 1.0) & (tAudio <= 1.1);
figure;
plot(tAudio(idxA), xHum(idxA), 'Color', [0.7 0.7 0.7]); hold on;
plot(tAudio(idxA), xClean(idxA), 'k', 'LineWidth', 1.3);
plot(tAudio(idxA), yAudio(idxA), 'b--', 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Audio Waveform (1.0 to 1.1 s)');
legend('Hum-Added', 'Clean Audio', 'Filtered (49-51 Hz)');
saveas(gcf, 'partB_waveform.png');

Na = length(xClean);
fa = Fs*(0:(Na/2))/Na;

Sc = abs(fft(xClean)/Na);
Sc1 = Sc(1:Na/2+1);
Sc1(2:end-1) = 2*Sc1(2:end-1);

Sh = abs(fft(xHum)/Na);
Sh1 = Sh(1:Na/2+1);
Sh1(2:end-1) = 2*Sh1(2:end-1);

Sf = abs(fft(yAudio)/Na);
Sf1 = Sf(1:Na/2+1);
Sf1(2:end-1) = 2*Sf1(2:end-1);

Sw = abs(fft(yAudioWide)/Na);
Sw1 = Sw(1:Na/2+1);
Sw1(2:end-1) = 2*Sw1(2:end-1);

figure;
plot(fa, Sh1, 'r', 'LineWidth', 1.1); hold on;
plot(fa, Sc1, 'k', 'LineWidth', 1.2);
plot(fa, Sf1, 'b--', 'LineWidth', 1.2);
plot(fa, Sw1, 'g:', 'LineWidth', 1.3);
xlim([0 200]);
grid on;
xlabel('Frequency (Hz)');
ylabel('Single-Sided Amplitude');
title('Audio Amplitude Spectrum (0 to 200 Hz)');
legend('Hum-Added', 'Clean Audio', 'Filtered (49-51 Hz)', 'Filtered (45-55 Hz)');
saveas(gcf, 'partB_spectrum.png');

band50 = (fa >= 49.5) & (fa <= 50.5);
fprintf('Clean 50 Hz: %.5f\n', max(Sc1(band50)));
fprintf('Hum-Added 50 Hz: %.5f\n', max(Sh1(band50)));
fprintf('Narrow Notch 50 Hz: %.5f\n', max(Sf1(band50)));
fprintf('Wider Notch 50 Hz: %.5f\n', max(Sw1(band50)));