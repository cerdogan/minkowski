% Pointwise multiplication of the sampled bump functions to check for 
% collision of two circles. Theorem 1 in lysenko2013ijrr.

% -------------------------------------------------------------------------
function [v1s,v2s] = s05_pointwise()

  % Generate the points
  clf;
  p1 = [1,1]; p2 = [1.7,1]; r = 0.5;
  drawCircle(p1, r);
  drawCircle(p2, r);
  axis([0 3 0 2]);
  
  % For each sample in the riemann sum, multiply the bump function values
  alpha = 1; offset = 0.0;
  integ = 0;
  v1s = []; v2s = [];
  for x = 0.5 : 0.1 : 2.4
    for y = 0 : 0.1 : 2
      v1 = s00_bump(norm([x,y]-p1)/r, alpha, offset);
      if(isinf(v1)), v1 = 1e6; end;
      v2 = s00_bump(norm([x,y]-p2)/r, alpha, offset);
      if(isinf(v2)), v2 = 1e6; end;
      if(abs(v2-1) < 1e-5), keyboard; end;
      v1s(end+1) = v1;
      v2s(end+1) = v2;
      integ = integ + v1*v2;
      %plot(x,y,'.');  hold on;
    end
  end
  keyboard
  fprintf('integral: %f\n', integ);

end

