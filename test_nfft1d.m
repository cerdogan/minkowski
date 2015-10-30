
% Copyright (c) 2002, 2015 Jens Keiner, Stefan Kunis, Daniel Potts
%
% This program is free software; you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free Software
% Foundation; either version 2 of the License, or (at your option) any later
% version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
% details.
%
% You should have received a copy of the GNU General Public License along with
% this program; if not, write to the Free Software Foundation, Inc., 51
% Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

% Test script of class nfft for spatial dimension d=1.
clear all;

M=32 % number of nodes
N = 32; %pow2(nextpow2(M));  % Transform length

rng(121354);
x=rand(M,1)-0.5; %nodes

% Initialisation
plan=nfft(1,N,M); % create plan of class type nfft
%n=2^(ceil(log(N)/log(2))+1);
%plan=nfft(1,N,M,n,7,bitor(PRE_PHI_HUT,PRE_PSI),FFTW_MEASURE); % use of nfft_init_guru

plan.x=x; % set nodes in plan
nfft_precompute_psi(plan); % precomputations

% NFFT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

randomValues=rand(N,1); % Fourier coefficients


% Compute samples with NFFT
plan.fhat=randomValues; % set Fourier coefficients
nfft_trafo(plan); % compute nonequispaced Fourier transform
f1=plan.f; % get samples

% Compute samples direct
k1=(-N/2:N/2-1).';
f2=zeros(M,1);
for j=1:M
  f2(j) = 0;
  for n = 1 : N
    f2(j)=f2(j) + randomValues(n) * exp(-2*pi*1i*k1(n)*x(j));
  end
end %for

power = f2.*conj(f2)/N;   % Power of the DFT
clf
subplot(2,1,1);
plot(x,'o-'); axis equal; hold on;
subplot(2,1,2);
plot(1:M,power); axis equal
grid on;
xlabel('Frequency (Hz)')
ylabel('Power')
title('{\bf Periodogram}')

% Compare results
max(abs(f1-f2))
