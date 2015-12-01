% Equation 8 in Jarek's paper suggests that the shape function can be
% represented as a convolution of center points and the ball function.
% Then, the fourier of the shape function should be the pointwise
% multiplication of the fourier of the center points and the fourier
% of the ball function. For implementation, assume center points are on
% a regular grid for now. 
% In addition, the bump function for ball0 is generated without all the 
% sample points and the rest are padded.

function [] = s10_uniformCentersB0_padded ()

  % Draw the possible circle centers
  clf;
  d = 0.2; low = -2; high = 3;
  K = (high - low) / d + 1
  ps = [];
  for x = low : d : high, for y = low : d : high, ps(end+1,:) = [x,y]; end, end;
  plot(ps(:,1),ps(:,2),'.'); hold on;
  
  % Draw the three circles
  p1 = [-1 + d*2, 1]; p2 = [1 - d*2, 2]; p3 = [1+d*2, -1];
  drawCircle(p1, 0.5, 'r');
  drawCircle(p2, 0.5, 'g');
  drawCircle(p3, 0.5, 'b');
  drawCircle([0,0], 0.5, 'c');
  
  % Generate the vector for centers
  rho = zeros(K,K);
  rho(K-round((p1(2)-low)/d),round((p1(1)-low)/d)+1) = 1;
  rho(K-round((p2(2)-low)/d),round((p2(1)-low)/d)+1) = 1;
  rho(K-round((p3(2)-low)/d),round((p3(1)-low)/d)+1) = 1;
  
  % Generate the vector for a circle centered at 1,1
  tic
  temp = -floor(0.5/d)*d:d:floor(0.5/d)*d;
  ps0 = temp(permn(1:5,2));
  v0 = s00_bump(sqrt(sum(ps0.*ps0,2))/0.5, 1);      % this is faster!!!!!!!
  %v0(find(isinf(v0))) = 1e1;
  v0 = reshape(v0, numel(temp), numel(temp));

  % Compute the fourier transforms 
  rhof = fft2(rho);
  v0f = fft2(v0,K,K);
  rhov0f = rhof.*v0f;
  toc
  
  % Generate the descriptor function for the entire shape
  tic
  psp1 = ps - repmat(p1, size(ps,1), 1);
  psp2 = ps - repmat(p2, size(ps,1), 1);
  psp3 = ps - repmat(p3, size(ps,1), 1);
  v = s00_bump(sqrt(sum(psp1.*psp1,2))/0.5, 1) + ...
    s00_bump(sqrt(sum(psp2.*psp2,2))/0.5, 1) + ...
    s00_bump(sqrt(sum(psp3.*psp3,2))/0.5, 1);
  %v(find(isinf(v))) = 1e1;
  v = reshape(v,26,26);
  
  % Compare with the fourier transform of the entire shape
  vf = fft2(v);
  toc
  assert(max(max(max(real(vf)-real(rhov0f))), max(max(imag(vf)-imag(rhov0f)))) < 1e-5);

end

