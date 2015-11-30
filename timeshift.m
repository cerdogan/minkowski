n=0:95;
%x = cos(pi/4*n);
A = [n;zeros(1,96)]';
%x = s00_bump(n/100,1,0.01)
x = rand(1,96);
x(1:6) = 0;
x(end-6:end) = 0;
delay=2;
y = zeros(1,96);
y(1,3:end) = x(1,1:end-2);
%y = s00_bump((2:97)/100,1,0.01)
size(y)
%y = cos(pi/4*(n-delay));
k=0:95;
% the DFT of y is exp(-1j*2*pi*k*delay/96)
phaseshift = exp(1j*2*pi*k*delay/96);
ydft = fft(y);
xdft = fft(x);
ydft=ydft.*phaseshift;
norm(xdft-ydft)
% 3.0397e-014
 max( max(real(xdft)-real(ydft)), max(imag(xdft)-imag(ydft)))