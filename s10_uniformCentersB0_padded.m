% Equation 8 in Jarek's paper suggests that the shape function can be
% represented as a convolution of center points and the ball function.
% Then, the fourier of the shape function should be the pointwise
% multiplication of the fourier of the center points and the fourier
% of the ball function. For implementation, assume center points are on
% a regular grid for now. 
% In addition, the bump function for ball0 is generated without all the 
% sample points and the rest are padded.

function [t1,t2] = s10_uniformCentersB0_padded (N)

  % Draw the possible circle centers
  figure(1);
  clf;
  d = 0.1; low = -2; high = 3;
  K = (high - low) / d + 1
  ps = [];
  for x = low : d : high, for y = low : d : high, ps(end+1,:) = [x,y]; end, end;
  plot(ps(:,1),ps(:,2),'.'); hold on;
  
  % Draw the three circles
 % cs = [-0.5 + d, 1;
 %       1 - d*5, 2;
 %       1+d*7, -3*d;
 %       0.4+d*2, 1.0;
 %       0.6+d*2, 0
 %       ];
 cs = [];
  for i = 1 : N
    maxI = round(((high-0.6)-(low+0.6))/d+1);
    cs(end+1,:) = [randi(maxI) * d + low+0.6, randi(maxI) * d + low+0.6];
  end
  %cs = [p1;p2;p3;p4;p5];
  %drawCircle([0,0], 0.5, 'c');
  
  % Generate the vector for centers
  rho = zeros(K,K);
  colors = {'r', 'g', 'b', 'c', 'k', 'm'};
  for i = 1 : size(cs,1)
    p = cs(i,:);
    drawCircle(p, 0.5, colors{mod(i,6)+1});
    rho(K-round((p(2)-low)/d),round((p(1)-low)/d)+1) = 1;
  end
  
  % Generate the vector for a circle centered at 1,1
  alpha = 1;
  tic
  temp = -floor(0.5/d)*d:d:floor(0.5/d)*d;
  ps0 = temp(permn(1:numel(temp),2));
  v0 = s00_bump(sqrt(sum(ps0.*ps0,2))/0.5, alpha);      % this is faster!!!!!!!
  %v0(find(isinf(v0))) = 1e1;
  v0 = reshape(v0, numel(temp), numel(temp));

  % Compute the fourier transforms 
  rhof = fft2(rho);
  v0f = fft2(v0,K,K);
  rhov0f = rhof.*v0f;
  t1 = toc;
  
  % Generate the descriptor function for the entire shape
  tic
  v = zeros(1,K*K);
  for i = 1 : size(cs,1)
    p = cs(i,:);
    psp = ps - repmat(p, size(ps,1), 1);
    v = v + s00_bump(sqrt(sum(psp.*psp,2))/0.5, alpha);
  end
  
  %v(find(isinf(v))) = 1e1;
  v(find(v>99)) = 150;
  v = reshape(v,K,K);
  %figure(2);
  %[X,Y] = meshgrid(low:d:high, low:d:high)
  %surf(X,Y,v)
  
  % Compare with the fourier transform of the entire shape
  vf = fft2(v);
  t2 = toc;
 % assert(max(max(max(real(vf)-real(rhov0f))), max(max(imag(vf)-imag(rhov0f)))) < 1e-3);

end

