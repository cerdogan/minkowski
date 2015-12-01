% Demonstrate that the fourier of the convolution of two signals with 
% different lengths can be computed by padding them with zeros.
function [] = s09_padding ()

  a = rand(8,1);
  b = rand(4,1);
  fa = fft(a, length(a) + length(b) - 1);
  fb = fft(b, length(a) + length(b) - 1);
  fab = fa.*fb;

  ab = conv(a,b);
  fab2 = fft(ab, length(a) + length(b) - 1);
  assert(max(max(max(real(fab)-real(fab2))), max(max(imag(fab)-imag(fab2)))) < 1e-5);

end