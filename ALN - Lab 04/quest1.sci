// Dados
P = [100 101 112 122 124 122 143 152 151 126 155 159 153 177 184 169 189 225 227 223 218 231 179 240];
L = [100 105 110 117 122 121 125 134 140 123 143 147 148 155 156 152 156 183 198 201 196 194 146 161];
K = [100 107 114 122 131 138 149 163 176 185 198 208 216 226 236 244 266 298 335 366 387 407 417 431];

// Calculando os logaritmos naturais
lnP = log(P);
lnL = log(L);
lnK = log(K);

// Número de observações
n = length(P);
// Matriz de design
X = [ones(n, 1), lnL', lnK'];
// Vetor de respostas
Y = lnP';

// Calculando a transposta de X
XT = X';

// Calculando X^T * X
XTX = XT * X;

// Calculando (X^T * X)^-1
XTX_inv = inv(XTX);

// Calculando X^T * Y
XTY = XT * Y;

// Calculando os coeficientes
B = XTX_inv * XTY;

// Extraindo os parâmetros
beta = B(1);
alpha_hat = B(2);
gamma_hat = B(3);

// Calculando b e corrigindo alpha
b = exp(beta);
alpha = alpha_hat / (alpha_hat + gamma_hat);  // Normalizando alpha

// Exibindo os resultados
disp("b = " + string(b));
disp("alpha = " + string(alpha));
    \end{lstlisting}
     
\subsection{Usando a função encontrada no item a) e fazendo um comparativo de valores}

\begin{lstlisting}[language=Scilab]
// Dados de 1910 e 1920
L_1910 = 147; K_1910 = 208;
L_1920 = 194; K_1920 = 407;

// Função de produção estimada
P_est_1910 = b * L_1910^alpha * K_1910^(1-alpha);
P_est_1920 = b * L_1920^alpha * K_1920^(1-alpha);

disp("Produção estimada para 1910: " + string(P_est_1910));
disp("Produção estimada para 1920: " + string(P_est_1920));

// Produção real
P_real_1910 = 159;
P_real_1920 = 231;

// Comparação
disp("Comparativo para 1910:");
disp("Produção Real: " + string(P_real_1910));
disp("Produção Estimada: " + string(P_est_1910));

disp("Comparativo para 1920:");
disp("Produção Real: " + string(P_real_1920));
disp("Produção Estimada: " + string(P_est_1920));
