% Given the fourier coefficients of a function, with the assumption
% that the coefficients were computed with n samples of the domain [0,2*pi],
% returns the samples of f at those domain values.
function fv = myDFTinv (C, n, check)

  % Implement DFT where dot product of w vector and f samples is
  % represented as a matrix multiplication;
  h = 2*pi/n;
  x = 0:h:2*pi-h/2;
  W = zeros(n,n);
  for k = 0 : (n-1)
    W(k+1,:) = exp(-k * j * x);
  end
  fv = W * C / n;
  
  % Check against matlab fft
  if(nargin > 2)
    assert(islogical(check));
    if(check)
      fv2 = [ifft(C',n)]';
      assert(sum(abs(fv-fv2)) < 1e-5);
      fprintf('FFT check correct\n');
    end
  end
  
end
