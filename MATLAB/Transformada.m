close all
clear all
clc


f1 = 1000; 
f2 = 1500; 
f3 = 1200; 
f4 = 2200; 
f5 = 2500; 


fs = 2000;                                        %Frequencia de Amostragem
ts= 1/fs;                                         %Tempo de Amostragem
t = 0:0.1:100;
sinal = sin((2*pi*f1*t/fs)) + cos((2*pi*f2*t/fs)) + cos((2*pi*f3*t/fs)) + 2*cos((2*pi*f4*t/fs)) + 2*sin((2*pi*f5*t/fs));



%dominio do tempo grafico
subplot(2,2,1);
plot(t,sinal);
title('Sinal - Tempo');
xlabel('tempo(s)');
ylabel('amplitude');
grid on;



N=length(sinal);
K=0:N-1;
T=N/fs;
freq=K/T;
YRuido=fftn(sinal)/N;
cutOff=ceil(N/2);
YRuido=YRuido(1:cutOff);

%dominio frequencia grafico
subplot(2,2,2);
plot(freq(1:cutOff),abs(YRuido));
title('Sinal - Frequencia');
xlabel('Frequencia');
ylabel('Modulo');






