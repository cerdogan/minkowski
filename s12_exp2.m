ts1 = []; ts2 = [];
for i = 1 : 10
  t1 = 0; t2 = 0;
  for j = 1 : 100
    [a,b] = s10_uniformCentersB0_padded(i);
    t1 = t1 + a;
    t2 = t2 + b;
  end
  ts1(end+1) = t1 / 10;
  ts2(end+1) = t2 / 10;
end
    
