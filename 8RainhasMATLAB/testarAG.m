clear all
close all
clc

tamanhoPop = 30;
taxa_mut = 5;
numRec = tamanhoPop;
N = 5;

for i=1:tamanhoPop
    d = DNA(N);
    individuos(i) = d;
end

pop = Populacao(individuos,taxa_mut,numRec);
pop.updateDados;
sair = pop.checar_fim(0);
while(sair == 1)  
    pop.selecao_roda;
    pop.nova_populacao;
    sair = pop.checar_fim(0);
end