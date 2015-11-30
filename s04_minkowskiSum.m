% For two given 0-1 matrices A and B, computes C such that for each nonzero a 
% and b in A and B respectively, at indices (ai,aj) and (bi,bj), C has a 
% 1 at (ai+bi,aj+bj) while the rest of the matrix is zero. size(C) = size(A) + size(B).
function C = s03_minkowskiSum (A, B)

	C = zeros(size(A) + size(B));
	[ra,ca] = find(A==1);
	[rb,cb] = find(B==1);
	for i = 1 : numel(ra)
		for j = 1 : numel(rb)
			rc = ra(i) + rb(j);
			cc = ca(i) + cb(j);
			C(rc-1,cc-1) = 1;
		end
	end
end
