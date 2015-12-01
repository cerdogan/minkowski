v = [0 1 0 0 0 0 1 1 1 0 0 0 1 0 1 0 0 1 1 0 0 1 0 1];

M=12; % number of nodes
N=12; % number of Fourier coefficients in first direction
x=(0:1/M:(1-1/M)) - 0.5;
x=x';

% Initialisation
plan=nfft(1,N,M); % create plan of class type nfft
plan.x=x; % set nodes in plan
nfft_precompute_psi(plan); % precomputations
plan.fhat=rand(N,1); % set Fourier coefficients
nfft_trafo(plan); % compute nonequispaced Fourier transform
f1=plan.f; % get samples