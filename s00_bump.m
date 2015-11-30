% The bump function defined as in Jarek's paper.

% -------------------------------------------------------------------------
function v = s00_bump (x, alpha, offset_)
  if(nargin > 2), offset = offset_; 
  else offset = 0; end;
  v = [];
  for i = 1 : numel(x)
    abs(x(i))
    if(abs(x(i)) < (1-1e-5)), v(end+1) = exp(1-power(abs(x(i))+offset,-alpha)).^-1;
    else v(end+1) = 0; end;
  end
end
% -------------------------------------------------------------------------