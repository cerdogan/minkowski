% Given two 2D shapes with sufficient number of circles (apparently at
% least 12), check if ...
function [] = s05_collisionNFFT () 

  addpath(genpath('3rdParty'));
  
  % Hardcode the center of the radii for the first shape
  clf
  P = [10,3; 7,7;13,9;5,10;18,12;9,13;12,17;5,17;8,21;13,23;3,24;13,29;3,30];
  P(:,2) = 30 - P(:,2);
  for i = 1 : size(P,1), drawCircle(P(i,:), 3.5); end;
  plot(P(:,1), P(:,2),'ko')
  
  % Take its symmetry
  P2 = P; 
  P2(:,1) = -P2(:,1) + 45;
  for i = 1 : size(P2,1), drawCircle(P2(i,:), 3.5, 'b'); end;
  plot(P2(:,1), P2(:,2),'bo')
  
  % Take the fourier transform using NFFT 
  % USE EQ 8. 
end