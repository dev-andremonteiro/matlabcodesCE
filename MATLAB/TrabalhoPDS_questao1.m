close all
clear all
clc

%dados
f1 = 1000; 
f2 = 3000; 
fs = 8000; %frequencia de amostragem
ts= 1/fs;% tempo de amostragem
fc = 1750; 
t = 0:1:1000;
x = 4*sin((2*pi*f1*t/fs)) + sin((2*pi*f2*t/fs));
%=======

%dominio do tempo grafico
subplot(2,1,1);
plot(t,x);
title('Sinal ruido');
xlabel('tempo(s)');
ylabel('amplitude');
grid on;

%fft
N=length(x);
K=0:N-1;
T=N/fs;
freq=K/T;
Y=fftn(x)/N;
%plot(freq,abs(Y));
cutOff=ceil(N/2);
Y=Y(1:cutOff);
subplot(2,1,2);
plot(freq(1:cutOff),abs(Y));
title('Sinal Frequencia');
xlabel('Frequencia');
ylabel('Modulo');
%================

%fitro
fc= (fc*2)/fs;
wc=fc;
filtro= fir1(100,wc,'low', hamming(101));
%===========
%resposta em freq do filtro
[H,w]= freqz(filtro,1);
figure();
subplot(2,1,1);
plot(w*fs/(2*pi),20*log10(abs(H)));
grid on;
title('Janela Hamming - Módulo');
xlabel('rad/s');
ylabel('amplitude');
subplot(2,1,2);
plot((w*fs)/(2*pi),angle(H)*(180/pi));
grid on;
title('Janela Hamming - Fase');
xlabel('rad/s');
ylabel('Fase');

%resposta ao impulso
[i,t]=impz(filtro,1);
figure();
plot(t,abs(i),'LineWidth',0.05);
title('resposta ao impulso');
xlabel('segundos');
ylabel('amplitude');
%====



%Filtragem
resposta = filter(filtro,1,x);
figure();
subplot(2,1,1);
plot(freq,resposta);
xlabel('tempo(s)');
ylabel('amplitude');
title('Sinal Filtrado');

%======

%Frequencia sinal filtrado
subplot(2,1,2);
resposta=fftn(resposta)/N;
plot(freq(1:cutOff),abs(resposta(1:cutOff)));
title('Sinal Frequencia');
xlabel('Frequencia');
ylabel('Modulo');
