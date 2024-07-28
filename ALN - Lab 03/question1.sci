function [lambda, x1, k, n_erro] = Metodo_potencia(A, x0, epsilon, M)
    // Inicialização de variáveis
    k = 0;
    n = length(x0);
    x0 = x0 / norm(x0, 'inf');
    x1 = A * x0;
    n_erro = epsilon + 1;
    
    // Loop principal
    while k <= M & n_erro >= epsilon
        // Calculando lambda usando o Quociente de Rayleigh
        lambda = x1' * x0 / (x0' * x0);
        // Corrigindo o sinal de x1, se necessário
        if lambda < 0 then
            x1 = -x1;
        end
        // Normalizando x1
        x1 = x1 / norm(x1, 2);
        // Calculando o erro
        n_erro = norm(x1 - x0, 'inf');
        // Atualizando x0 para o próximo ciclo
        x0 = x1;
        // Atualizando x1
        x1 = A * x0;
        // Atualizando o contador de iterações
        k = k + 1;
    end

    // Mensagem de retorno
    if n_erro < epsilon then
        disp('Convergência alcançada.');
    else
        disp('Número máximo de iterações atingido.');
    end

    // Retorno dos resultados
    lambda = x1' * x0 / (x0' * x0); // lambda final
    x1 = x1 / norm(x1, 2); // autovetor final normalizado
endfunction
