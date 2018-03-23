fs = 400e4;
f = 100;
numCiclos = 5;
t=0:1/fs:numCiclos*1/f;
x=cos(2*pi*f*t);

fs1=400;
t1=0:1/fs1:numCiclos*1/f;
x1=cos(2*pi*f*t1);

subplot(2,1,1);
plot(t,x);
hold on;
stem(t1,x1);