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

// Previsões no conjunto de treinamento
y_pred_train = X_train * alpha;
y_pred_train = (y_pred_train >= 0) * 2 - 1;  // Classificando: +1 se >= 0, caso contrário -1

// Previsões no conjunto de teste
y_pred_test = X_test * alpha;
y_pred_test = (y_pred_test >= 0) * 2 - 1;  // Classificando: +1 se >= 0, caso contrário -1

// Porcentagem de acertos no conjunto de treinamento
accuracy_train = sum(y_pred_train == y_train) / length(y_train);

// Porcentagem de acertos no conjunto de teste
accuracy_test = sum(y_pred_test == y_test) / length(y_test);

disp("Acurácia no conjunto de treinamento: " + string(accuracy_train * 100) + "%");
disp("Acurácia no conjunto de teste: " + string(accuracy_test * 100) + "%");

// Inicializando a matriz de confusão
confusion_matrix = zeros(2, 2);

// Preenchendo a matriz de confusão
for i = 1:length(y_test)
    if y_test(i) == 1 then
        if y_pred_test(i) == 1 then
            confusion_matrix(1, 1) = confusion_matrix(1, 1) + 1;  // Verdadeiro positivo
        else
            confusion_matrix(1, 2) = confusion_matrix(1, 2) + 1;  // Falso negativo
        end
    else
        if y_pred_test(i) == 1 then
            confusion_matrix(2, 1) = confusion_matrix(2, 1) + 1;  // Falso positivo
        else
            confusion_matrix(2, 2) = confusion_matrix(2, 2) + 1;  // Verdadeiro negativo
        end
    end
end

disp("Matriz de Confusão:");
disp(confusion_matrix);

TP = confusion_matrix(1, 1);
FN = confusion_matrix(1, 2);
FP = confusion_matrix(2, 1);
TN = confusion_matrix(2, 2);

accuracy = (TP + TN) / (TP + TN + FP + FN);
precision = TP / (TP + FP);
recall = TP / (TP + FN);
false_alarm_rate = FP / (FP + TN);
false_omission_rate = FN / (FN + TP);

disp("Acurácia: " + string(accuracy));
disp("Precisão: " + string(precision));
disp("Recall: " + string(recall));
disp("Taxa de Falsos Alarmes: " + string(false_alarm_rate));
disp("Taxa de Falsas Omissões: " + string(false_omission_rate));
