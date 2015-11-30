% Shows that the fourier transform of the 2D bump function map (sampled) 
% can be generated from the fourier transform of the same map translated
% within the sampling rate.

function [] = s07_fourierShift()

  % Define the two circles
  p1 = [1,1]; 
  p2 = [1.7,1.4]; 
  r = 0.5;
  xlow = 0.3; ylow = 0; dx = 0.1; dy = 0.1;
  dp = p2-p1;
  assert(abs(round(dp(1)/dx)*dx-dp(1)) < 1e-5);
  assert(abs(round(dp(2)/dy)*dy-dp(2)) < 1e-5);

  % For each sample in the riemann sum, multiply the bump function values
  alpha = 1; offset = 0.0;
  integ = 0;
  K = 24;
  v1s = zeros(K,K); v2s = zeros(K,K);

  for x_i = 1 : 24
    for y_i = 1 : 24
      x = xlow + x_i * dx;
      y = ylow + y_i * dy;
      v1 = s00_bump(norm([x,y]-p1)/r, alpha, offset);
      if(isinf(v1)), v1 = 1e6; end;
      v2 = s00_bump(norm([x,y]-p2)/r, alpha, offset);
      if(isinf(v2)), v2 = 1e6; end;
      v1s(y_i,x_i) = v1;
      v2s(y_i,x_i) = v2;
      integ = integ + v1*v2;
      %plot(x,y,'.');  hold on;
    end
  end

  % Take the fourier transforms
  f1 = fft2(v1s);
  f2 = fft2(v2s);

  % Phase shift
  dr = round(dp(2) / dy);
  dc = round(dp(1) / dx);
  phaseshift = zeros(K,K);
  for r = 1 : K
    for c = 1 : K
      phaseshift(r,c) = exp(1j*2*pi*(-dr*(r-1)/K+-dc*(c-1)/K));
    end
  end

  f2b = f1.*phaseshift;
  assert(max(max(max(real(f2)-real(f2b))), max(max(imag(f2)-imag(f2b)))) < 1e-5);

end


