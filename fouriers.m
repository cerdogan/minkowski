fs = 16;                                % Sample frequency (Hz)
ns = 0:0.1:pi;
x = (1.3)*sin(2*pi*15*(ns-1)*(1/fs));             % 15 Hz component
 
m = length(x);          % Window length
n = pow2(nextpow2(m));  % Transform length
y = fft(x,n);           % DFT
f = (0:n-1)*(fs/n);     % Frequency range
power = y.*conj(y)/n;   % Power of the DFT

clf
subplot(2,2,1);
plot(ns,x,'o-'); axis equal; hold on;
subplot(2,2,2);
plot(f,power); axis equal
grid on;
xlabel('Frequency (Hz)')
ylabel('Power')
title('{\bf Periodogram}')

ns2 = sort(rand(numel(ns),1) * max(ns));
x2 = (1.3)*sin(2*pi*15*(ns2-1)*(1/fs));
subplot(2,2,3); 
plot(ns2,x2,'o-r'); 

subplot(2,2,4); 
y2 = fft(x2,n);           % DFT
power2 = y2.*conj(y2)/n;   % Power of the DFT
plot(f,power2); axis equal
xlabel('Frequency (Hz)')
ylabel('Power')
grid on;