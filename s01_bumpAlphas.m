function [] = s00_bump ()

  xs = -2:0.01:2;
  ys01 = exp(1-power(abs(xs),-0.1)).^-1;
  ys1 = exp(1-power(abs(xs),-1)).^-1;
  ys10 = exp(1-power(abs(xs),-10)).^-1;
  ys100 = exp(1-power(abs(xs),-100)).^-1;
  plot(xs,ys01,'r',xs,ys1,'g',xs,ys10,'b',xs,ys100,'k');
  legend('a=0.1','a=1.0','a=10.0','a=100.0')
  axis([-2 2 0 10])
  title('Bump function with different \alpha values', 'FontSize', 36);
  set(gca,'fontsize',20)

  ylabel('\psi_{\alpha}(x)');

end