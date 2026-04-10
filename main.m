%Rozwiązywanie układów równań liniowych (Linear Systems Solver) 
%by Piotr Kijowski
clearvars; clc; close all;

%% 1. Dane
n = 10;
A = rand(n,n) + n*eye(n); % Macierz dominująca przekątniowo
b = rand(n,1);

%% 2. Rozwiązywania
tic;
x_gauss = gauss_solver(A, b); %Metoda eliminacji Gaussa
t_gauss = toc;

tic;
x_lu = lu_solver(A, b);
t_lu = toc;

tic;
x_iterative = iterative_solver(A, b);
t_iterative = toc;

%% 3. Porównanie wyników
error_gauss = norm(A*x_gauss - b); %Rezyduum - różnica między lewą a prawą stroną równania  Ax=b
fprintf('Błąd Gaussa: %e, Czas: %f s\n', error_gauss, t_gauss);

error_lu = norm(A*x_lu - b);
fprintf('Błąd LU: %e, Czas: %f s\n', error_lu, t_lu);

error_iterative = norm(A*x_iterative - b);
fprintf('Błąd Iterative:  %e, Czas: %f s\n', error_iterative, t_iterative);


%% 4. Wizualizacja

%Wizualizacja błędu metody eliminacji gaussa w zależności od wielkości
%macierzy (n - wielkość macierzy)
ns = 10:20:300;

errors_gauss = zeros(1, length(ns));
errors_lu = zeros(1, length(ns));
errors_iterative = zeros(1, length(ns));

times_gauss = zeros(1, length(ns));
times_lu = zeros(1, length(ns));
times_iterative = zeros(1, length(ns));

for i = 1:length(ns)
    current_n = ns(i);
    A_test = rand(current_n) + current_n*eye(current_n); 
    b_test = rand(current_n, 1);
   
    tic;
    x_g = gauss_solver(A_test, b_test);
    times_gauss(i) = toc;
    errors_gauss(i) = norm(A_test*x_g - b_test) + eps;

    tic;
    x_l = lu_solver(A_test, b_test);
    times_lu(i) = toc;
    errors_lu(i) = norm(A_test*x_l - b_test) + eps;
    
    tic;
    x_i = iterative_solver(A_test, b_test);
    times_iterative(i) = toc;
    errors_iterative(i) = norm(A_test*x_i - b_test) + eps;
end

subplot(2,1,1)

semilogy(ns, errors_gauss, '-ro', 'DisplayName', 'Gauss'); hold on;
semilogy(ns, errors_lu, '-bs', 'DisplayName', 'LU');
semilogy(ns, errors_iterative, '-g^', 'DisplayName', 'Iterative'); hold off;
xlabel('Rozmiar macierzy n')
ylabel('Norma błędu')
title('Stabilność zaimplementowanych metod')
legend('Location', 'best')
grid on;

subplot(2,1,2)

plot(ns, times_gauss, '-ro', 'DisplayName', 'Gauss'); hold on;
plot(ns, times_lu, '-bs', 'DisplayName', 'LU');
plot(ns, times_iterative, '-g^', 'DisplayName', 'Iterative'); hold off;
xlabel('Rozmiar macierzy (n)')
ylabel('Czas wykonania (s)')
title('Porównanie złożoności zaimplementowanych metod')
legend('Location', 'best')
grid on;
