// Leitura dos dados de treinamento
train_data = csvRead('cancer_train_2024.csv', ';');
X_train = train_data(:, 1:10); // Características
y_train = train_data(:, 11);   // Diagnósticos

// Leitura dos dados de teste
test_data = csvRead('cancer_test_2024.csv', ';');
X_test = test_data(:, 1:10);   // Características
y_test = test_data(:, 11);     // Diagnósticos


// Adicionando uma coluna de 1s para o termo constante (intercepto)
X_train = [ones(size(X_train, 1), 1) X_train];
X_test = [ones(size(X_test, 1), 1) X_test];

// Transposta de X_train
XT_train = X_train';

// Calculando (X^T * X)
XTX = XT_train * X_train;

// Calculando (X^T * X)^-1
XTX_inv = inv(XTX);

// Calculando X^T * y_train
XTY = XT_train * y_train;

// Calculando os coeficientes
alpha = XTX_inv * XTY;

// Exibindo os coeficientes
disp("Coeficientes do modelo original:");
disp(alpha);

// Exibindo os coeficientes para análise
disp("Coeficientes do modelo original:");
for i = 1:size(alpha, 1)
    disp("alpha(" + string(i-1) + ") = " + string(alpha(i)));
end

// Removendo as variáveis 4 e 7 (ajustando os índices pois a primeira coluna é o intercepto)
X_train_reduced = X_train(:, [1:4, 6:7, 9:11]);  // Mantendo intercepto e variáveis 1, 2, 3, 5, 6, 8, 9, 10
X_test_reduced = X_test(:, [1:4, 6:7, 9:11]);  // Mantendo intercepto e variáveis 1, 2, 3, 5, 6, 8, 9, 10

// Transposta de X_train_reduced
XT_train_reduced = X_train_reduced';

// Calculando (X^T * X) para o modelo reduzido
XTX_reduced = XT_train_reduced * X_train_reduced;

// Calculando (X^T * X)^-1 para o modelo reduzido
XTX_inv_reduced = inv(XTX_reduced);

// Calculando X^T * y_train para o modelo reduzido
XTY_reduced = XT_train_reduced * y_train;

// Calculando os coeficientes do modelo reduzido
alpha_reduced = XTX_inv_reduced * XTY_reduced;

// Previsões no conjunto de treinamento reduzido
y_pred_train_reduced = X_train_reduced * alpha_reduced;
y_pred_train_reduced = (y_pred_train_reduced >= 0) * 2 - 1;  // Classificando: +1 se >= 0, caso contrário -1

// Previsões no conjunto de teste reduzido
y_pred_test_reduced = X_test_reduced * alpha_reduced;
y_pred_test_reduced = (y_pred_test_reduced >= 0) * 2 - 1;  // Classificando: +1 se >= 0, caso contrário -1

// Porcentagem de acertos no conjunto de treinamento reduzido
accuracy_train_reduced = sum(y_pred_train_reduced == y_train) / length(y_train);

// Porcentagem de acertos no conjunto de teste reduzido
accuracy_test_reduced = sum(y_pred_test_reduced == y_test) / length(y_test);

disp("Acurácia no conjunto de treinamento reduzido: " + string(accuracy_train_reduced * 100) + "%");
disp("Acurácia no conjunto de teste reduzido: " + string(accuracy_test_reduced * 100) + "%");

// Inicializando a matriz de confusão para o modelo reduzido
confusion_matrix_reduced = zeros(2, 2);

// Preenchendo a matriz de confusão para o modelo reduzido
for i = 1:length(y_test)
    if y_test(i) == 1 then
        if y_pred_test_reduced(i) == 1 then
            confusion_matrix_reduced(1, 1) = confusion_matrix_reduced(1, 1) + 1;  // Verdadeiro positivo
        else
            confusion_matrix_reduced(1, 2) = confusion_matrix_reduced(1, 2) + 1;  // Falso negativo
        end
    else
        if y_pred_test_reduced(i) == 1 then
            confusion_matrix_reduced(2, 1) = confusion_matrix_reduced(2, 1) + 1;  // Falso positivo
        else
            confusion_matrix_reduced(2, 2) = confusion_matrix_reduced(2, 2) + 1;  // Verdadeiro negativo
        end
    end
end

disp("Matriz de Confusão para o modelo reduzido:");
disp(confusion_matrix_reduced);

TP_reduced = confusion_matrix_reduced(1, 1);
FN_reduced = confusion_matrix_reduced(1, 2);
FP_reduced = confusion_matrix_reduced(2, 1);
TN_reduced = confusion_matrix_reduced(2, 2);

accuracy_reduced = (TP_reduced + TN_reduced) / (TP_reduced + TN_reduced + FP_reduced + FN_reduced);
precision_reduced = TP_reduced / (TP_reduced + FP_reduced);
recall_reduced = TP_reduced / (TP_reduced + FN_reduced);
false_alarm_rate_reduced = FP_reduced / (FP_reduced + TN_reduced);
false_omission_rate_reduced = FN_reduced / (FN_reduced + TP_reduced);

disp("Acurácia (reduzido): " + string(accuracy_reduced));
disp("Precisão (reduzido): " + string(precision_reduced));
disp("Recall (reduzido): " + string(recall_reduced));
disp("Taxa de Falsos Alarmes (reduzido): " + string(false_alarm_rate_reduced));
disp("Taxa de Falsas Omissões (reduzido): " + string(false_omission_rate_reduced));

