clc
clear all

F1 = 500; 
F2 = 1500;
F3 = 3300;
F4 = 4000;
Fa = 1e4;
Fc = 3000;
t = [0:1/Fa:1000];


y = 6*sin(2*pi*F1*t)+3*sin(2*pi*F2*t)+1*sin(2*pi*F3*t)+5*sin(2*pi*F4*t);

NFFT = 1024;

Y = fft(y,NFFT);

Y = Y(1:NFFT/2);

magY = abs(Y);

f = (0:NFFT/2-1)*Fa/NFFT; 

plot(f,magY);

