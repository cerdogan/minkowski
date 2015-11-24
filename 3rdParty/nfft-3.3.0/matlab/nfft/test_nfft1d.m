
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

M=12; % number of nodes
N=12; % number of Fourier coefficients in first direction

x=rand(M,1)-0.5; %nodes
%x=(0:1/M:(1-1/M)) - 0.5;
%x=x'

% Initialisation
plan=nfft(1,N,M); % create plan of class type nfft
plan.x=x; % set nodes in plan
nfft_precompute_psi(plan); % precomputations

fhat=rand(N,1); % Fourier coefficients
fhat = sin(x);
fhatv=fhat(:);


% Compute samples with NFFT
plan.fhat=fhatv; % set Fourier coefficients
nfft_trafo(plan); % compute nonequispaced Fourier transform
f1=plan.f; % get samples

% Compute samples direct
k1=(-N/2:N/2-1).';
f2=zeros(M,1);
for j=1:M
	x1j=x(j,1);
	f2(j)= 0.0; %sum( fhatv.*exp(-2*pi*1i*k1*x1j) );
  for k = 0 : N-1
    f2(j) = f2(j) + fhatv(k+1) * exp((-2*pi*1i*k1(k+1)*x(j)));
  end
    
end %for

% Compare results
max(abs(f1-f2))


