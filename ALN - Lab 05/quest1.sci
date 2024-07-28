// Função para realizar a decomposição QR utilizando o método de Gram-Schmidt
function [Q, R] = qr_GS(A)
    [m, n] = size(A);
    Q = zeros(m, n);
    R = zeros(n, n);

    for k = 1:n
        v = A(:,k);
        for j = 1:k-1
            R(j,k) = Q(:,j)' * A(:,k);
            v = v - R(j,k) * Q(:,j);
        end
        R(k,k) = norm(v);
        Q(:,k) = v / R(k,k);
    end
endfunction

// Função para verificar a ortogonalidade
function check_orthogonality(Q)
    I = Q' * Q;
    disp('Q'' * Q = ');
    disp(I);
    if norm(I - eye(size(Q, 2))) < 1e-10 then
        disp('Q é ortogonal.');
    else
        disp('Q NÃO é ortogonal.');
    end
endfunction

// Função para verificar a acurácia da decomposição QR
function check_accuracy(A, Q, R)
    A_reconstructed = Q * R;
    disp('Q * R = ');
    disp(A_reconstructed);
    if norm(A - A_reconstructed) < 1e-10 then
        disp('A decomposição QR está correta.');
        disp(norm(A - A_reconstructed))
    else
        disp('A decomposição QR NÃO está correta.');
    end
endfunction

// Definindo algumas matrizes de teste
A1 = [1, 0; 1, 1];
A2 = [1, 1, 1; 1, 2, 3; 1, 3, 6];
A3 = rand(4, 4); // Matriz aleatória 4x4
A4 = [1, 7, 1; 5, 2, 3; 1, 3, 11];

// Testando com a matriz A1
disp('Testando com A1:');
A = A1;
[Q, R] = qr_GS(A);
disp('Matriz A1:');
disp(A1);
disp('Matriz Q:');
disp(Q);
disp('Matriz R:');
disp(R);
check_orthogonality(Q);
check_accuracy(A, Q, R);

// Testando com a matriz A2
disp('Testando com A2:');
A = A2;
[Q, R] = qr_GS(A);
disp('Matriz A2:');
disp(A2);
disp('Matriz Q:');
disp(Q);
disp('Matriz R:');
disp(R);
check_orthogonality(Q);
check_accuracy(A, Q, R);

// Testando com a matriz A3
disp('Testando com A3:');
A = A3;
[Q, R] = qr_GS(A);
disp('Matriz A3:');
disp(A3);
disp('Matriz Q:');
disp(Q);
disp('Matriz R:');
disp(R);
check_orthogonality(Q);
check_accuracy(A, Q, R);

// Testando com a matriz A4
disp('Testando com A4:');
A = A4;
[Q, R] = qr_GS(A);
disp('Matriz A4:');
disp(A4);
disp('Matriz Q:');
disp(Q);
disp('Matriz R:');
disp(R);
check_orthogonality(Q);
check_accuracy(A, Q, R);
