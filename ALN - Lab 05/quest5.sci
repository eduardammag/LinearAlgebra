// Função para calcular os autovalores de uma matriz simétrica usando o Algoritmo QR
function [S] = espectro(A, tol)
    // Verifica se a matriz é simétrica
    if norm(A - A', 'fro') > 1e-10 then
        error("A matriz não é simétrica.")
    end
    
    // Inicializa variáveis
    n = size(A, 1);  // Dimensão da matriz
    Ak = A;  // Copia de A para modificações
    diff = %inf;  // Inicializa diferença com infinito
    S_prev = diag(Ak);  // Inicia S_prev como os elementos da diagonal de A
    
    // Itera até que a diferença seja menor que a tolerância
    while diff > tol
        // Fatoração QR
        [Q, R] = qr(Ak);
        
        // Atualiza Ak
        Ak = R * Q;
        
        // Autovalores atuais são os elementos da diagonal de Ak
        S_curr = diag(Ak);
        
        // Calcula a diferença entre espectros consecutivos
        diff = norm(S_curr - S_prev, 'inf');
        
        // Atualiza S_prev
        S_prev = S_curr;
    end
    
    // Ordena os autovalores em ordem crescente para facilitar a comparação
    S = gsort(S_curr, "g", "i");
endfunction

// Teste com três matrizes diferentes cujos autovalores são conhecidos

// Teste 1: Matriz simétrica simples
A1 = [4, 1, 1;
      1, 4, 1;
      1, 1, 4];
tol1 = 1e-6;
S1 = espectro(A1, tol1);
disp("Autovalores de A1 calculados:")
disp(S1);
disp("Autovalores de A1 esperados:")
disp([2, 2, 6]);

// Teste 2: Matriz simétrica de ordem 2
A2 = [2, -1;
     -1, 2];
tol2 = 1e-7;
S2 = espectro(A2, tol2);
disp("Autovalores de A2 calculados:")
disp(S2);
disp("Autovalores de A2 esperados:")
disp([1, 3]);

// Teste 3: Outra matriz simétrica
A3 = [3, 2, 4;
      2, 0, 2;
      4, 2, 3];
tol3 = 1e-8;
S3 = espectro(A3, tol3);
disp("Autovalores de A3 calculados:")
disp(S3);
disp("Autovalores de A3 esperados:")
disp([-1, 1, 6]);
