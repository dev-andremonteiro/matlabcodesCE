classdef DNA < handle
    properties
        genes
        fitness
        tamanho
    end
    methods
        
        function obj = DNA(N)
            if nargin > 0
                obj.tamanho = N;
                for i = 1:N
                    obj.genes(i) = randi([1 N]);
                end
            end
        end
        
        function calcFitness(obj)
            tabuleiro(1:obj.tamanho,1:obj.tamanho) = 0;
            for i= 1:obj.tamanho
                tabuleiro(obj.genes(i),i) = 1; %não tem como ter na mesma coluna.
            end
            %%checar se existem rainhas na mesma linha
            colisao = 0;
            for i=1:obj.tamanho
                lin = obj.genes(i);
                for j=1:obj.tamanho
                    if(tabuleiro(lin,j) == 1 && j ~= i) %Verificar se não é a própria peça.
                        colisao = colisao + 1;
                    end
                end
            end
            
            %%checar se existem rainhas na mesma diagonal
            for col=1:obj.tamanho
                lin = obj.genes(col);
                
                for dl = 1:-2:-1
                    for dc = 1:-2:-1
                        for z = 1:obj.tamanho
                            
                            nova_linha = lin+(dl*z);
                            nova_coluna = col+(dc*z);
                            
                            if(nova_linha < 1 || nova_linha > obj.tamanho || nova_coluna < 1 || nova_coluna > obj.tamanho)
                                break;
                            end
                            if(tabuleiro(nova_linha,nova_coluna) == 1 && nova_linha ~= lin && nova_coluna ~= col)%Verificar se não é a própria peça.
                                colisao = colisao + 1;
                            end
                        end
                    end
                end
                
            end
            
            obj.fitness = colisao;
        end
        
        function r = crossOver(obj,parceiro)
            r = DNA(obj.tamanho);
            meio = randi([1 obj.tamanho]);
            for i =1:obj.tamanho
                if(meio > i)
                    r.genes(i) = obj.genes(i);
                else
                    r.genes(i) = parceiro.genes(i);
                end
            end
        end
        
        function r = crossOver2(obj,parceiro)
            r = DNA(obj.tamanho);
            k = 1;
            for i = 1:obj.tamanho
                if(obj.genes(i) == parceiro.genes(i))
                    r.genes(k) = obj.genes(k);
                    k = k + 1;
                end
            end
            
            for i = k:obj.tamanho
                if((mod(i,2)) == 1)
                    r.genes(i) =  obj.genes(i);
                else
                    r.genes(i) =  parceiro.genes(i);
                end
            end
        end

        function r = crossOver3(obj,parceiro)
            r = DNA(obj.tamanho);
            meio = randi([2 obj.tamanho]);
            vet = zeros([1 meio]);
            for i =1:obj.tamanho
                if(meio > i)
                    r.genes(i) = obj.genes(i);
                    vet(i) = obj.genes(i);                    
                end
            end
            for k =1:obj.tamanho
                existe = 0;
                for j = 1:meio
                    if(vet(j) == parceiro.genes(k))
                        existe = 1;
                        break;
                    end
                end
                if(existe == 0)
                    meio = meio + 1;
                    if(meio > obj.tamanho)
                        break;
                    else
                        vet(meio) = parceiro.genes(k);
                    end
                end
            end
                    
        end
        
        function mutacao(obj,tax)
            for i = 1:obj.tamanho
                mut = randi([1 100]);
                %So acontece em tax%.
                if(mut < tax)
                    obj.genes(i) = randi([1 obj.tamanho]);
                end
                
            end
            
        end
    end
end