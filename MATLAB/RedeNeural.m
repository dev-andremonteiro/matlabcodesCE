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
        
 [0 1; 0 1] - Limite padrões entrada 

 [2 2] - Número neuronio de cada entrada

 {logsig logsig} - função de transferência opções de cada camada 
                        Logsig -> signóide
                        purelin -> linear
                        tanseg -> tangente hiperbolica
                        satlin -> linear c/ saturação
                       
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