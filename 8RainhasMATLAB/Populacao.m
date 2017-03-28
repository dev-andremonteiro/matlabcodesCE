classdef Populacao < handle
    properties
        individuos
        taxaMut
        taxaRec
        tamanhoPop
        roda
        geracao
        fit_menor = DNA(1);
        fit_media
    end
    methods
        
        function obj = Populacao(ind,taxa,rec)
            if nargin > 0
                obj.individuos = ind;
                obj.taxaMut = taxa;
                obj.taxaRec = rec;
                obj.tamanhoPop = length(ind);
                obj.geracao = 1;
            end
        end
        
        function selecao_roda(obj)
            j=1;
            for i=1:obj.tamanhoPop
                f = (1/obj.individuos(i).fitness)*100;
                f = floor(f);
                k = 0;
                while(k<f)
                    obj.roda(j) = i;
                    j=j+1;
                    k=k+1;
                end
            end
        end
        
        function updateDados(obj)
            obj.fit_media = 0;
            for i =1:obj.tamanhoPop
                obj.individuos(i).calcFitness();
                obj.fit_media = obj.individuos(i).fitness + obj.fit_media;
            end
            obj.fit_media = obj.fit_media/obj.tamanhoPop;
            obj.bubble_sort();
            obj.fit_menor(obj.geracao) = obj.individuos(obj.tamanhoPop);
            
            X = ['Geracao: ',num2str(obj.geracao),' Media: ',num2str(obj.fit_media),' Menor: ',num2str(obj.fit_menor(obj.geracao).fitness),'.'];
            disp(X);
        end
        
        function bubble_sort(obj)
            for i = 1:obj.tamanhoPop
                for j = 1:obj.tamanhoPop-1
                    if(obj.individuos(j).fitness < obj.individuos(j+1).fitness)
                        aux = obj.individuos(j);
                        obj.individuos(j) = obj.individuos(j+1);
                        obj.individuos(j+1) = aux;
                    end
                end
            end
        end
        
        function nova_populacao(obj)
            maxRoda = length(obj.roda);
            for i = 1:obj.taxaRec
                z = randi([1 maxRoda]);
                z = obj.roda(z);
                y = randi([1 maxRoda]);
                y = obj.roda(y);
                filhos(i) = obj.individuos(z).crossOver(obj.individuos(y));%%CrossOver
                filhos(i).mutacao(obj.taxaMut);%%Mutacao
            end
            obj.individuos = filhos;
            obj.geracao = obj.geracao + 1;
            obj.updateDados();
        end
        
        function z = checar_fim(obj,y)
            z = 1;
            if(y < 1)
                for i=1:obj.tamanhoPop
                    if(obj.individuos(i).fitness == 0)
                        z = 0;
                    end
                end
            else
                if((y - obj.geracao) == 0)
                    z = 0;
                end
                
            end
        end
        
    end
    
end