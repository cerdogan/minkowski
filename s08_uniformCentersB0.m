% Equation 8 in Jarek's paper suggests that the shape function can be
% represented as a convolution of center points and the ball function.
% Then, the fourier of the shape function should be the pointwise
% multiplication of the fourier of the center points and the fourier
% of the ball function. For implementation, assume center points are on
% a regular grid for now. 

%function [] = s08_uniformCentersB0 ()

  % Draw the possible circle centers
  clf;
  d = 0.2; low = 0; high = 5;
  K = (high - low) / d + 1
  ps = [];
  for x = low : d : high, for y = low : d : high, ps(end+1,:) = [x,y]; end, end;
  plot(ps(:,1),ps(:,2),'.'); hold on;
  
  % Draw the three circles
  p1 = [1 + d*2, 3]; p2 = [3 - d*2, 4]; p3 = [3+d*2, 1];
  drawCircle(p1, 0.5, 'r');
  drawCircle(p2, 0.5, 'g');
  drawCircle(p3, 0.5, 'b');
  drawCircle([1,1], 0.5, 'c');
  
  % Generate the vector for centers
  rho = zeros(K,K);
  rho(K-round(p1(2)/d),round(p1(1)/d)+1) = 1;
  rho(K-round(p2(2)/d),round(p2(1)/d)+1) = 1;
  rho(K-round(p3(2)/d),round(p3(1)/d)+1) = 1;

  % Generate the vector for a circle centered at 1,1
%end

