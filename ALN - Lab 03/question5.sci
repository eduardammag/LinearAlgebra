// Função para gerar uma matriz simétrica aleatória com autovalores conhecidos
function A = gerar_matriz_simetrica_autovalores(autovalores)
    n = length(autovalores);
    A = zeros(n, n);
    for i = 1:n
        for j = i:n
            A(i, j) = rand() * 10 - 5; // Números aleatórios entre -5 e 5
            if i == j then
                A(i, j) = autovalores(i); // Definir autovalores na diagonal principal
            else
                A(j, i) = A(i, j); // Preencher elementos simétricos
            end
        end
    end
endfunction

// Teste dos algoritmos com diferentes matrizes e condições iniciais
n = 5; // Ordem da matriz
autovalores = [10, 8, 6, 4, 2]; // Autovalores conhecidos
A = gerar_matriz_simetrica_autovalores(autovalores); // Gerar matriz simétrica com autovalores conhecidos
x0 = rand(n, 1); // Vetor inicial aleatório
epsilon = 1e-6; // Precisão
M = 100; // Número máximo de iterações

// Testar Método da Potência
disp("Teste Método da Potência:");
[lambda1, x1, k1, n_erro1] = Metodo_potencia(A, x0, epsilon, M);
disp("Autovalor estimado:");
disp(lambda1);
disp("Número de iterações para convergência:");
disp(k1);

// Testar Método da Potência Deslocada com Iteração Inversa
disp("Teste Método da Potência Deslocada com Iteração Inversa:");
[lambda2, x2, k2, n_erro2] = Potencia_deslocada_inversa(A, x0, epsilon, 5, M);
disp("Autovalor estimado:");
disp(lambda2);
disp("Número de iterações para convergência:");
disp(k2);
