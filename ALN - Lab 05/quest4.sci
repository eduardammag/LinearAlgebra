// Função para testar os diferentes métodos de decomposição QR
function test_qr_methods(A)
    disp('Testando matriz: ');
    disp(A);
    
    // Testando qr_GS
    [Q_GS, R_GS] = qr_GS(A);
    disp('Resultados para qr_GS:');
    disp('Q = ');
    disp(Q_GS);
    disp('R = ');
    disp(R_GS);
    check_orthogonality(Q_GS);
    check_accuracy(A, Q_GS, R_GS);

    // Testando qr_GSM
    [Q_GSM, R_GSM] = qr_GSM(A);
    disp('Resultados para qr_GSM:');
    disp('Q = ');
    disp(Q_GSM);
    disp('R = ');
    disp(R_GSM);
    check_orthogonality(Q_GSM);
    check_accuracy(A, Q_GSM, R_GSM);
    
    // Testando qr_GSP
    [Q_GSP, R_GSP, P_GSP] = qr_GSP(A);
    disp('Resultados para qr_GSP:');
    disp('Q = ');
    disp(Q_GSP);
    disp('R = ');
    disp(R_GSP);
    disp('P = ');
    disp(P_GSP);
    check_orthogonality(Q_GSP);
    check_accuracy(A * P_GSP, Q_GSP, R_GSP); // A precisa ser ajustada pelo pivoteamento

    // Testando qr_House_v1
    [U1, R1] = qr_House_v1(A);
    Q1 = constroi_Q_House(U1);
    disp('Resultados para qr_House_v1:');
    disp('Q = ');
    disp(Q1);
    disp('R = ');
    disp(R1);
    check_orthogonality(Q1);
    check_accuracy(A, Q1, R1);

    // Testando qr_House_v2
    [U2, R2] = qr_House_v2(A);
    Q2 = constroi_Q_House(U2);
    disp('Resultados para qr_House_v2:');
    disp('Q = ');
    disp(Q2);
    disp('R = ');
    disp(R2);
    check_orthogonality(Q2);
    check_accuracy(A, Q2, R2);
endfunction

// Definindo algumas matrizes de teste
A1 = [1, 0; 1, 1];
A2 = [1, 1, 1; 1, 2, 3; 1, 3, 6];
A3 = rand(4, 4); // Matriz aleatória 4x4
A4 = [1, 7, 1; 5, 2, 3; 1, 3, 11];
A5 = [12, -51, 4; 6, 167, -68; -4, 24, -41]; // Matriz do exemplo

// Aplicando o script de teste nas matrizes de teste
test_qr_methods(A1);
test_qr_methods(A2);
test_qr_methods(A3);
test_qr_methods(A4);
test_qr_methods(A5);

// Matrizes adicionais para teste
M1 = testmatrix('magi', 7);
H = testmatrix('hilb', 7);
M2 = testmatrix('magi', 6);

test_qr_methods(M1);
test_qr_methods(H);
test_qr_methods(M2);
