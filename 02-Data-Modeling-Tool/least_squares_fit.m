function y_test = least_squares_fit(x_pomiar, y_pomiar, x_test, stopien)
    % degree - stopień wielomianu (1 = linia, 2 = parabola )

    x_pomiar = x_pomiar(:); y_pomiar = y_pomiar(:);

    % Macierz Vandermonde'a

    V = zeros(length(x_pomiar), stopien + 1);
    for j = 0:stopien
        V(:, stopien + 1 - j) = x_pomiar.^j;
    end

    % Układ równań

   a = V \ y_pomiar; % Zastępuje (V' * V) * a = V' * y_pomiar

   y_test = polyval(a, x_test);
end
