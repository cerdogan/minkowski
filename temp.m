clf;
x = [0:0.01:2*pi];
plot(x, exp(-2*j*x)); hold on;
plot(x, exp(6*j*x))

n = 8;
h = 2*pi/n;
x2 = [0:h:2*pi];
plot(x2, exp(-2*j*x2), 'ro'); hold on;
plot(x2, exp(6*j*x2), 'k*');