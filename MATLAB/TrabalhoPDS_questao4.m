close all
clear all
clc

%{
Questão 4 - Fazer uma aplicação de processamento de áudio no matlab 
escolhendo o filtro que desejar. Pegar o sinal de áudio adicionar um ruído
e implementar um filtro para tentar remover o ruído.
%}

% LENDO O AUDIO
%--------------------------------------------------------------------------------------------------------
[Sound,Fs,Prec] = wavread('H.wav');       % Ler audio no formato wav.
Mono = (Sound(:,1)+Sound(:,2))/2;         % Transformação de Estéreo para Mono.
x = Mono;                                 % A variavel x será nosso audio.
A = length(x)/8;                          % Obtendo o tamanho do audio e reduzindo.
x = x(1:A,:);                             % Limitando o tempo do audio (Tempo total 4 minutos).
A = length(x);                            % Atualizando tamanho do audio.
n = 0:A-1;                                % Obtendo 0>n>A-1.
figure(1);                                % Selecionando em qual figura deverá ser mostrado o plot a seguir.
plot(n,x);                                % Mostrar gráfico de X em relação a n
T = A/Fs;                                 % Periodo de amostragem (1/Fs)*A.
freq = n/T;                               %
Y = fftn(x)/A;                            % Cálculo da transformada de Fourier.
cutOff = ceil(A/2);                       % Obtendo a metade do tamanho das amostras.
Y = Y(1:cutOff);                          % Limitando a transformada a metade positiva.
figure(2);                                %
plot(freq(1:cutOff),abs(Y));              %
title('Sinal Frequencia');                %
xlabel('Frequencia');                     %
ylabel('Modulo');                         %
%--------------------------------------------------------------------------------------------------------

% GERANDO O RUIDO
%--------------------------------------------------------------------------------------------------------

freqRuido = 2e10;                         % Frequência da Primeira senoide.
freqRuido2 = 3e10;                        % Frequência da Segunda senoide.
                                        
                                        
Dur = A/Fs;                               % Obtendo a duração do audio de acordo com a quantidade de amostras.
Ts = 1/Fs;                                %
t = [0:Ts:Dur-Ts];                        % Voltando para o tempo.
ruido = 10000*sin(2*pi*t*freqRuido/Fs)+180*sin(2*pi*t*freqRuido2/Fs);     %Sinal do ruído.
audiowrite('ruido.wav',ruido,Fs);         % Gravando sinal do ruido.
A2 = length(ruido);                       % Obtendo o tamanho do ruido.
K2 = 0:A2-1;                              % Obtendo 0>K2>A2-1.
figure(3);                                %
plot(K2,ruido);                           %
T2 = A2/Fs;                               % Periodo de amostragem (1/Fs)*A2.
freq2 = K2/T2;                            % 
Y2 = fftn(ruido)/A2;                      % Cálculo da transformada de Fourier.
cutOff2 = ceil(A2/2);                     % Obtendo a metade do tamanho das amostras.
Y2 = Y2(1:cutOff2);                       % Limitando a transformada a metade positiva.
figure(4);                                %
plot(freq2(1:cutOff2),abs(Y2));           %
title('Sinal Frequencia Ruido');          %
xlabel('Frequencia');                     %
ylabel('Modulo');                         %
%--------------------------------------------------------------------------------------------------------

% INSERINDO O RUIDO
%--------------------------------------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%
  filtrar = ruido'+x;                     % Adicionando a transposta de ruido em X.
%%%%%%%%%%%%%%%%%%%%%%%
audiowrite('filtrar.wav',filtrar,Fs);     % Gravando sinal que deve ser filtrado.
A3 = length(filtrar);                     % Obtendo o tamanho de filtrar.
K3 = 0:A3-1;                              % Obtendo 0>K3>A3-1.
figure(5), plot(K3,filtrar);              % 
T3 = A3/Fs;                               % Periodo de amostragem (1/Fs)*A3.
freq3 = K3/T3;                            % 
Y3 = fftn(ruido)/A3;                      % Cálculo da transformada de Fourier.
cutOff3 = ceil(A3/2);                     % Obtendo a metade do tamanho das amostras.
Y3 = Y3(1:cutOff3);                       % Limitando a transformada a metade positiva.
figure(6);                                %
plot(freq3(1:cutOff3),abs(Y3));           %
title('Sinal Frequencia Ruido');          %
xlabel('Frequencia');                     %
ylabel('Modulo');                         %
%--------------------------------------------------------------------------------------------------------

% FILTRANDO O RUIDO 
%--------------------------------------------------------------------------------------------------------

fp = 8000;                                % Largura banda de passagem Hz.
fr = 10000;                               % Banda de rejeição Hz.
Ap = 2;                                   % Ganho banda de passagem dB. (0.1)
Ar = 20;                                  % Atenuação banda de rejeição dB. (6)
Wp = fp/(Fs/2);                           % Frequencia fp normalizada.
Wr = fr/(Fs/2);                           % Frequencia fr normalizada.

%%%%%%%%%%%%%%%%%%%%%%%
[N,Wc] = cheb1ord(Wp,Wr,Ap,Ar,'s');       % Função retorna os parâmetros N e Wc do filtro IIR Butterworth.
[p,m] = cheby1(N,Ap,Wc);                  % Retorna os coeficientes do filtro.
%%%%%%%%%%%%%%%%%%%%%%%
[h,w] = freqz(p,m,1014);                  % Função retorna a resposta em frequência filtro
figure(7);                                %
plot(w*Fs/(2*pi),20*log10(abs(h)));       % 
title('Modulo');                          % 
figure(8);                                %
plot(w*Fs/(2*pi),(180/pi)*angle(h));      % 
title('Fase do Filtro');                  % 

%%%%%%%%%%%%%%%%%%%%%%%%
   z = filter(p,m,x);                     % Obtendo o filtro implementado na estrutura direta II transposta.
%%%%%%%%%%%%%%%%%%%%%%%%
audiowrite('filtrado.wav',z,Fs);          % Gravando sinal filtrado.
figure(9);                                % 
plot(n,z);                                %
title('Sinal de Saída Filtrado');         %

z = fftn(z)/A;                            % Cálculo da transformada de Fourier.
figure(10);                               % 
plot(freq(1:cutOff),abs(z(1:cutOff)));    % 
title('Sinal Filtrado Frequência');       % 
xlabel('Frequencia');                     % 
ylabel('Modulo');                         % 
%--------------------------------------------------------------------------------------------------------


