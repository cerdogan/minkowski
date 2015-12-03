% For two given 0-1 matrices A and B, computes C such that for each nonzero a 
% and b in A and B respectively, at indices (ai,aj) and (bi,bj), C has a 
% 1 at (ai+bi,aj+bj) while the rest of the matrix is zero. size(C) = size(A) + size(B).
% Do this, by taking the fourier transform of the matrices and piecewise multiplying them.
function C = s05_minkowskiSumFT (A, B)

	% Make the two matrices bigger
	A2 = zeros(size(A) + size(B));
	A2(1:size(A,1), 1:size(A,2)) = A;
	B2 = zeros(size(A) + size(B));
	B2(1:size(B,1), 1:size(B,2)) = B;

	% Take their 2D fourier transforms
	fA = fft2(A2);
	fB = fft2(B2);

	% Piecewise multiply (which is convolution in time space)
	fC = fA .* fB;
  
	% Bring it back to space domain
%	C = ifft2(fC);

end
