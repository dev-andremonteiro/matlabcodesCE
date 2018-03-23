close all
clear all
clc


%%%%%%%%%%%%%%%% Criando o sinal digital que deve ser transmitido %%%%%%%%%%%%%%%%

d = [ 1 0 1 1 0 1 1 1 0 0 ];

display('Mensagem Trasmitida');
disp(d);

%%%%%%%%%%%%%%%% Arbritando o perido da onda portadora e do sinal digital %%%%%%%%%%%%%%%%

f = 1000;
p = 1/f;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% Criando a onda retangular que representa o sinal digital %%%%%%%%%%%%%%%%

sinaldig = [];
for(i = 1:length(d))

    if(d(i) == 1);
        aux = ones(1,100);
    else(d(i) == 0);
        aux = zeros(1,100);
    end
    sinaldig = [sinaldig aux];                                 %Concatenação do sinal digital
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% Criação do gráfico do sinal digital de entrada %%%%%%%%%%%%%%%%

t = p/100:p/100:length(d)*p;
subplot(3,1,1);
plot(t,sinaldig,'lineWidth',2.5);
grid on;
axis([ 0 p*length(d) -.5 1.5]);
ylabel('Amplitude(V)');
xlabel('Tempo(s)');
title('Sinal digital a ser transmitido');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CRIAÇÃO DA ONDA PORTADORA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A=3;

t2 = p/100:p/100:p;
portadoraMod = [];


for(i = 1:length(d))

    if(d(i) == 1);
        aux2 = A*cos(2*pi*f*t2);
    else(d(i) == 0);
        aux2 = A*cos((2*pi*f*t2) + pi);
    end
    portadoraMod = [portadoraMod aux2];                                          
end

%%%%%%%%%%%%%%%% Criação do gráfico da onda portadora %%%%%%%%%%%%%%%%

subplot(3,1,2);
plot(t,portadoraMod);
ylabel('Amplitude(V)');
xlabel('Tempo(s)');
title('Sinal da Portadora');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%    DEMODULAÇÃO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pt2 = length(t2);
dS = [];
for n=pt2:pt2:length(portadoraMod)
  %%Existem vários modos de se fazer.
  
  if(portadoraMod(n) == A);
    auxD = 1;
  else
    auxD = 0;
  end
  dS = [dS auxD];
end

display('Mensagem Recebida')
disp(dS);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Montando sinal digital recebido %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sinaldigsaida = [];
for(i = 1:length(dS))

    if(dS(i) == 1);
        aux3 = ones(1,100);
    else(dS(i) == 0);
        aux3 = zeros(1,100);
    end
    sinaldigsaida = [sinaldigsaida aux3];                                   
end

subplot(3,1,3);
plot(t,sinaldigsaida,'lineWidth',2.5);
grid on;
axis([ 0 p*length(d) -.5 1.5]);
ylabel('Amplitude(V)');
xlabel('Tempo(s)');
title('Sinal digital recebido');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

