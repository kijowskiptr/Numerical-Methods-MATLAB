%Aproksymacja i Modelowanie Danych (Data Approximation & Modeling Tool) 
%by Piotr Kijowski
clearvars; clc; close all;

%% 1. Dane
% Parametry S_p i u_p
lp_pomiarowych = 10;
gest_wyk = 1000;

x_pomiar = -2 + (3 - (-2)) * rand(1, lp_pomiarowych);
%y_pomiar = randn(1, lp_pomiarowych) * 10 - 5;
y_pomiar = 2 * x_pomiar + 5;
x_test = linspace(-2, 3, gest_wyk);

%Dodanie szumu
mu = 0; sigma = 2;
szum = mu + sigma * randn(1,lp_pomiarowych);
y_real = y_pomiar + szum;


%% 2. Implementacja funkcji 

y_lagrange = lagrange_interp(x_pomiar, y_real, x_test);
y_lsm = least_squares_fit(x_pomiar, y_real, x_test, 1);


%% 3. Analiza błędów

y_obl_lsm = least_squares_fit(x_pomiar, y_real, x_pomiar, 1);
y_obl_lag = lagrange_interp(x_pomiar, y_real, x_pomiar);

stats_lag = calculate_metrics(y_real, y_obl_lag);
stats_lsm = calculate_metrics(y_real, y_obl_lsm);

fprintf('\n___DOKŁADNOŚĆ MODELU LSM____\n');
fprintf('\n_______DOKŁADNOŚĆ LSM_______ \n');
fprintf('RMSE: %.4f\n', stats_lsm.rmse);
fprintf('MAE: %.4f\n', stats_lsm.mae)
fprintf('R^2: %.4f\n', stats_lsm.r2)
fprintf('\n')

fprintf('_____DOKŁADNOŚĆ LAGRANGEA_____\n');
fprintf('RMSE: %.4f\n', stats_lag.rmse);
fprintf('\n')


if stats_lsm.r2 > 0.8
    fprintf('Ocena LSM: Model jest bardzo dobrze dopasowany.\n')
elseif stats_lsm.r2 > 0.5
    fprintf('Ocena LSM: Model poprawny, ale dane są wyraźnie zaszumione.\n')
else
    fprintf('Ocena LSM: Model słabo dopasowany.\n')
end

%% 4. Wizualizacja 

subplot(2,1,1)
plot(x_pomiar, y_real, 'ro', 'MarkerSize', 8, 'DisplayName', [num2str(lp_pomiarowych) ' punktów pomiarowych']); 
hold on;
plot(x_test, y_lagrange, 'g--', 'LineWidth', 1, 'DisplayName', 'Interpolacja Lagrangea'); 
plot(x_test, y_lsm, 'b-', 'LineWidth', 2, 'DisplayName', 'LSM'); hold off;
grid on;
legend('Location', 'best');
title('Porównanie Interpolacji (Lagrange) i Aproksymacji (LSM)');
xlabel('u'); ylabel('y');


subplot(2,1,2)
plot(x_pomiar, y_real, 'ro', 'MarkerSize', 8, 'DisplayName', [num2str(lp_pomiarowych) ' punktów pomiarowych']); 
hold on;
plot(x_test, y_lagrange, 'g--', 'LineWidth', 1, 'DisplayName', 'Interpolacja Lagrangea'); 
plot(x_test, y_lsm, 'b-', 'LineWidth', 2, 'DisplayName', 'LSM'); hold off;
grid on;
legend('Location', 'best');
title('Przybliżony wykres, aby uniknąć eksplozji wielomianu 9-tego stopnia');
xlabel('u'); ylabel('y');
ylim([min(y_real)-20, max(y_real)+20]);