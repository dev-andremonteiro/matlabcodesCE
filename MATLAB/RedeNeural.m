close all
clear all

%{ 
1)Definir Base Dados
 2)Inicializar Rede
 3)Definir parametro treinamento
 4)Treinar a Rede
 5)Utilizar a Rede
%}

P = [1 1 0 0; 1 0 0 1];
T = [1 0 1 0];


net = newff(minmax(P),[2 1], {'logsig' 'logsig'}, 'trainlm');


%{
newff - Backpropagation
         newp - perceptron
         newcf - fledforword retro casc
         newelm - elman retro porp
        
 [0 1; 0 1] - Limite padr�es entrada 

 [2 2] - N�mero neuronio de cada entrada

 {logsig logsig} - fun��o de transfer�ncia op��es de cada camada 
                        Logsig -> sign�ide
                        purelin -> linear
                        tanseg -> tangente hiperbolica
                        satlin -> linear c/ satura��o
                       
 {traingd} - Algoritmo de treinamento
                     trainlm
                     traingdm
                     traingda
                     traingdx
%}
                    
 net.trainParam.Epochs = 100;
 %*numero epocas/momento/aprend 


net = train(net,P,T);

r = sim(net,P);
r;