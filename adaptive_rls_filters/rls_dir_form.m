% Adaptive RLS filter - Direct Form implementation
%
% Optimization is needed. Filter is not giving desired results yet

% generating the test signals
T = 0.01;
n = 0:T:50-T;
L = length(n);
s = sin(n);   %s = ones(1, L); 
noise = wgn(1, L, -0.5);
signal = s + 0.5*noise; % sinusiod with additive noise

M = 44;                 % filter size
delta = 0.001;          % initialising (small positive value)
w = 0.999;              % forgetting factor (0 < w < 1)
Xm = zeros(M, 1);       % filter input vector (noise)
Hm = zeros(M, 1);       % filter coeffient vector
Pm = (1/delta)*eye(M);  % inverse correlation matrix
er = zeros(1, L);       % error vector (output)

for i = 1:L
    Xm = [noise(i); Xm(1:M-1)]; % get X(n) from X(n-1) and new input 
    
    % compute error
    d_hat = Xm'*Hm;     % filter output
    d = signal(i);      % desired output    
    em = d - d_hat;     % error       
    er(i) = em; 
    
    % kalman gain vector
    Km = (Pm*Xm)/(w + Xm'*Pm*Xm);   
    % update inverse correlation matrix
    Pm = (1/w)*(Pm - Km*Xm'*Pm);
    
    % update filter coefficients
    Hm = Hm + Km*em;     
end

figure;
plot(n, signal);
title('Signal corrupted with noise');
ylim([-5, 5]);
figure
plot(n, er);
title('Error signal from RLS filter');
ylim([-5, 5]);