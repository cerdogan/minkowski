% Visualize the first object with two circles
clf;
t0 = [-3, 0]; r0 = 3;
drawCircle(t0, r0, 'r');

% Visualize the second object with a circle
t1 = [4, -2]; r1 = 2.5;
drawCircle(t1, r1, 'b');
axis([-10 10 -10 10]);

% Compute the fourier tranform of the first defining function f1
syms x1 x2 real; 
f1 = exp(1-power(sqrt((x(1)-t0(1)).^2 + (x(2)-t0(2)).^2)/r0,-0.1)).^-1;
ff1 = fourier(f1);

% Compute the fourier tranform of the second defining function f2
f2 = exp(1-power(sqrt((x(1)-t1(1)).^2 + (x(2)-t1(2)).^2)/r0,-0.1)).^-1;
ff2 = fourier(f2);

% Compose the transforms
fg = ff1 * conj(ff2);
