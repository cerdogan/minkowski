% Given a function f, sample it at the interval [0,2*pi] with n samples
% and generate w vectors that have the evaluation of complex exponentials
% at those samples. Using w vectors and f, compute the Fourier
% coefficients.
function C = myDFT (f, n, check)

  % Implement DFT where dot product of w vector and f samples is
  % represented as a matrix multiplication;
  h = 2*pi/n;
  x = 0:h:2*pi-h/2;
  fv = f(x);
  W = zeros(n,n);
  for k = 0 : (n-1)
    W(k+1,:) = exp(k * j * x);
  end
  C = W * fv';
  
  % Check against matlab fft
  if(nargin > 2)
    assert(islogical(check));
    if(check)
      C2 = [fft(fv,n)]';
      assert(sum(abs(C-C2)) < 1e-5);
      fprintf('FFT check correct\n');
    end
  end
  
end
