clear; clc; close all;

pop=500; %População
seq=300; %Números em cada elemento da população
mut=0.1; %Taxa de Mutação


goal=1:seq; %Vetor goal indica o elemento ideal (objetivo)
elementos = randi([1 seq], pop, seq); %Cria uma matrix de população com valores aleatórios


geracao=1; %Começa na primeira geração 
while true
    [elementos, melhor]=avaliar(elementos, pop, mut, seq, goal);
    geracao=geracao+1;
    subplot(2,1,1);
    plot(melhor);
    subplot(2,1,2);
    scatter([1:seq],melhor);
    pause(0.001);
    if melhor==goal
        break;
    end
end
txt=['Número de gerações: ' num2str(geracao)'.'];
subplot(2,1,1);
text(100,150,txt);
fprintf('Número de gerações: %d',geracao);






function [elementos,melhor] = avaliar(elementos, pop, mut, seq, goal)
    notas=zeros(pop,1);
    total=0;
    mutacao=round(1/mut);
    
    
    %elementos %PRINT
    
    %AVALIACAO
    for i=1:pop
        for j=1:seq
            if elementos(i,j)==j
                notas(i,1)=notas(i,1)+1;
                total=total+1;
            end
        end
    end
    
    %notas %PRINT
    %total %PRINT

        
    

    %CAIXA COM OS ELEMENTOS CLASSIFICADOS
    caixa_selecao=zeros(total,seq);
    num=1;
    for i=1:pop
        for j=1:notas(i,1)
            caixa_selecao(num,:)=elementos(i,:);
            num=num+1;
        end
    end
    
    %caixa_selecao %PRINT
    
    %Melhor classificado
    melhor_nota=notas(1,1);
    melhor=elementos(1,:);
    for i=2:pop
        if notas(i,1)>melhor_nota
            melhor_nota=notas(i,1);
            melhor=elementos(i,:);
        end
    end

            
    %CRIAR NOVA POPULACAO
    
    pais=zeros(2,seq);
    for i=1:pop
        pais(1,:)=caixa_selecao(randi([1 total]),:);
        pais(2,:)=caixa_selecao(randi([1 total]),:);
        for j=1:seq
            if pais(1,j)==goal(1,j)     %Se um pai tiver o gene certo
                elementos(i,j)=pais(1,j);
            elseif pais(2,j)==goal(1,j) %Se o outro pai tiver o gene certo
                elementos(i,j)=pais(2,j); 
            elseif randi([1 mutacao])==1 %Aplicar mutacao com probabilidade d
                elementos(i,j)=randi([1 seq]);
            else
                elementos(i,j)=pais(randi([1 2]),j); %Escolhe o gene do pai 1 OU do pai 2
            end
        end
    end

    %elementos
   
    

end


