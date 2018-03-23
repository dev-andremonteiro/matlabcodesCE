num = [1 0.2];
a = conv([1 0.012],[1 5.02]);
den = conv([1 0],a);
rlocus(num,den);