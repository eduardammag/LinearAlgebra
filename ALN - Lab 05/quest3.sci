// Função que implementa o Método de Gram-Schmidt Modificado com Pivoteamento de Colunas
function [Q, R, P] = qr_GSP(A)
    [m, n] = size(A); // Obtém as dimensões da matriz A
    Q = zeros(m, n); // Inicializa a matriz Q
    R = zeros(n, n); // Inicializa a matriz R
    P = eye(n, n); // Inicializa a matriz de permutação P como uma matriz identidade

    // Calcula as normas das colunas de A
    col_norms = zeros(1, n);
    for j = 1:n
        col_norms(j) = norm(A(:, j));
    end

    for k = 1:n
        // Encontra a coluna com a maior norma entre as colunas restantes
        [max_norm, max_index] = max(col_norms(k:n));
        max_index = max_index + k - 1;

        // Permuta as colunas se necessário
        if k ~= max_index
            A(:, [k, max_index]) = A(:, [max_index, k]);
            P(:, [k, max_index]) = P(:, [max_index, k]);
            col_norms([k, max_index]) = col_norms([max_index, k]);
        end

        // Normaliza a coluna escolhida para obter o vetor ortonormal
        R(k, k) = norm(A(:, k));
        Q(:, k) = A(:, k) / R(k, k);

        // Subtrai as projeções das colunas restantes sobre o vetor ortonormal
        for j = k+1:n
            R(k, j) = Q(:, k)' * A(:, j);
            A(:, j) = A(:, j) - Q(:, k) * R(k, j);
        end

        // Atualiza as normas das colunas restantes
        for j = k+1:n
            col_norms(j) = norm(A(:, j));
        end
    end
end

// Script de teste para verificar a funcionalidade da função qr_GSP

// Matriz de exemplo para teste
A = [12, -51, 4; 6, 167, -68; -4, 24, -41];

// Chamando a função qr_GSP
[Q, R, P] = qr_GSP(A);

// Exibindo os resultados
disp("Q = ");
disp(Q);

disp("R = ");
disp(R);

disp("P = ");
disp(P);

// Verificando se AP = QR
disp("AP = ");
disp(A * P);

disp("QR = ");
disp(Q * R);

// Comparação de precisão com o método QR nativo do Scilab
[Q_native, R_native] = qr(A);
disp("Erro método nativo: ");
disp(norm(A - Q_native * R_native));

disp("Erro método GSP com pivoteamento: ");
disp(norm(A * P - Q * R));

