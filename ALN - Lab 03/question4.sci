// Gerar uma matriz simétrica aleatória
n = 5; // ordem da matriz
A = rand(n, n);
A = A + A'; // tornar a matriz simétrica

// Calcular os Discos de Gerschgorin para estimar os autovalores
r = sum(abs(A), 2) - abs(diag(A)); // raio de cada disc
centros = diag(A); // centro de cada disco
disp('Discos de Gerschgorin:');
for i = 1:n
    disp(sprintf('Autovalor estimado %d: Intervalo [%f, %f]', i, centros(i) - r(i), centros(i) + r(i)));
end

// Parâmetros para o Método da Potência Deslocada com Iteração Inversa
x0 = ones(n, 1); // vetor inicial
epsilon = 1e-6; // precisão
M = 1000; // número máximo de iterações

// Usar os autovalores estimados como valores iniciais para o Método da Potência Deslocada com Iteração Inversa
for i = 1:n
    alfa = centros(i); // valor desejado de autovalor
    [lambda_deslocada, x1_deslocada, k_deslocada, n_erro_deslocada] = Potencia_deslocada_inversa(A, x0, epsilon, alfa, M);
    disp(sprintf('Autovalor %d calculado: %f', i, lambda_deslocada));
    disp(sprintf('Número de iterações para autovalor %d: %d', i, k_deslocada));
end
