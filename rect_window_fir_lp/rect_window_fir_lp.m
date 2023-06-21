% Design a rectangular window FIR low-pass filter

m = 6;      % filter order
n = 0:1:m;  
wc = 0.2;   % normalised cutoff frequency (wc*pi)

h = wc*sinc(wc*(n-m/2));      % filter impluse response(rectangular window)

% test lp filter for a sinusoid corrupted by noise
ti = 0.01;                    % sample interval
n1 = 0:ti:100-ti;
s = 1.5*sin(0.1*pi*n1);
noise = wgn(1, 10000, -0.5);
signal = s + noise;          %signal corrupted with awgn

filtered = conv(h, signal);  %filter the signal (convolution)

figure;
plot(signal);
title('Signal corrupted by AWGN');

figure;
plot(filtered);
title('Low pass filtered singal');

% magnitude response of the filter
fvtool(h, 1);