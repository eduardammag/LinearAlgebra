// Definição da matriz A de ordem 3
A3 = [4 1 2; 1 5 3; 2 3 6];

// Vetor inicial x0n
x0 = [1; 1; 1];

// Parâmetros comuns para os testes
epsilon = 1e-6; // precisão
M = 1000; // número máximo de iterações

// Testando Método da Potência
tic();
[lambda_potencia, x1_potencia, k_potencia, n_erro_potencia] = Metodo_potencia(A3, x0, epsilon, M);
tempo_potencia = toc();

disp('Resultado do Método da Potência:');
disp(lambda_potencia);
disp('Número de iterações:');
disp(k_potencia);
disp('Tempo de execução:');
disp(tempo_potencia);

// Testando Método da Potência Deslocada com Iteração Inversa
alfa = 5; // valor desejado de autovalor
tic();
[lambda_deslocada, x1_deslocada, k_deslocada, n_erro_deslocada] = Potencia_deslocada_inversa(A3, x0, epsilon, alfa, M);
tempo_deslocada = toc();

disp('Resultado do Método da Potência Deslocada com Iteração Inversa:');
disp(lambda_deslocada);
disp('Número de iterações:');
disp(k_deslocada);
disp('Tempo de execução:');
disp(tempo_deslocada);
