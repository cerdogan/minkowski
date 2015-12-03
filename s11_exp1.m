
ts1 = []; ts2 = [];
for s = 3:20
  t1 = 0; t2 = 0;
  N = 100;
  for i = 1 : N

    M = 100;
    A = round(rand(s,s));
    B = round(rand(s,s));
    for j = 1 : M
      tic;
      s04_minkowskiSum(A,B);
      t1 = t1 + toc;
      tic
      s05_minkowskiSumFT(A,B);
      t2 = t2 + toc;
    end
  end
  t1 = t1 / (N * M);
  t2 = t2 / (N * M);
  ts1(end+1) = t1;
  ts2(end+1) = t2;
  s
end