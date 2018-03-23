fs=8000; % freqüência de Amostragem Hz
fp=1000; % largura banda de passagem Hz
fr=3000; % banda de rejeição Hz
Ap=2; % Ganho banda de passagem dB
Ar=20; % Atenuação banda de rejeição dB

f1=50; % freqüência dentro da banda de passagem Hz
f2=500; % freqüência dentro da banda de passagem Hz
f3=2000 ; % frequencia dentro da faixa de atenuação Hz
f4=1500; % frequencia dentro da faixa de atenuação Hz
t=0:1:1000;
x=6*sin((2*pi*f1*t/fs))+4*sin((2*pi*f2*t/fs))+0.5*sin((2*pi*f3*t/fs))+3*sin((2*pi*f4*t/fs));
%dominio do tempo grafico
figure(1);
plot(t,x);
title('Sinal ruido');
xlabel('tempo(s)');
ylabel('amplitude');
grid on;

%fft
A=length(x);
K=0:A-1;
T=A/fs;
freq=K/T;
Y=fftn(x)/A;
%plot(freq,abs(Y));
cutOff=ceil(A/2);
Y=Y(1:cutOff);
figure(2);
plot(freq(1:cutOff),abs(Y));
title('Sinal Frequencia');
xlabel('Frequencia');
ylabel('Modulo');
%================

%Frequencia normalizada
 
Wp =fp/(fs/2); %0.4
Wr =fr/(fs/2); %0.8
%Filtro IIR Butterworth
[N,Wn]=buttord(Wp,Wr,Ap,Ar);

[n,m] = butter(N,Wn);
 
%Filtrando o Sinal
 
z = filter(n,m,x);
figure(3);
plot(t,z);
title('Sinal de Saída Filtrado');
%=====
%Sinal filtrado freq
figure(4);
z=fftn(z)/A;
plot(freq(1:cutOff),abs(z(1:cutOff)));
title('Sinal Filtrado Frequencia');
xlabel('Frequencia');
ylabel('Modulo');


%Resposta frequencia filtro
[h,w]=freqz(n,m,1014);
figure(5);
plot(w*fs/(2*pi),20*log10(abs(h)));
title('Modulo');
figure(6),
plot((w*fs)/(2*pi),angle(h)*(180/pi));
title('Fase do Filtro');
