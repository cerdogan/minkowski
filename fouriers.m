fs = 64;                                % Sample frequency (Hz)
ns = 0:0.1:pi;
x = (1.3)*sin(2*pi*15*(ns-1)*(1/fs));             % 15 Hz component

M = length(x);          % Window length
N = pow2(nextpow2(M));  % Transform length

% Compute samples direct
if(true)
  for k=1:M
    y(k) = 0.0;
    for n = 1 : N
      y(k) = X(k) + x(n) * exp(-2*pi*1i*(k-1)*(n-1)/N);
    end
  end
else
  y = fft(x,N);           % DFT
end

f = (0:N-1)*(fs/N);     % Frequency range
power = y.*conj(y)/N;   % Power of the DFT
clf
subplot(2,2,1);
plot(ns,x,'o-'); axis equal; hold on;
subplot(2,2,2);
plot(f,power); axis equal
grid on;
xlabel('Frequency (Hz)')
ylabel('Power')
title('{\bf Periodogram}')

% Generate the non-equispaced data
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
