  xs = -2:0.01:2;
  ys01 = s00_bump(xs, 0.1);
  ys1 = s00_bump(xs, 1);
  ys10 = s00_bump(xs, 10);
  ys100 = s00_bump(xs, 100);
  plot(xs,ys01,'-dr',xs,ys1,'g-o',xs,ys10,'b-*',xs,ys100,'ks-');
  legend('a=0.1','a=1.0','a=10.0','a=100.0')
  axis([-2 2 -0.5 10])
  title('Bump function with different \alpha values', 'FontSize', 36);
  set(gca,'fontsize',20)
set(gcf,'color','w');
  ylabel('\psi_{\alpha}(x)');