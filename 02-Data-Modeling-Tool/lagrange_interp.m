function y_test = lagrange_interp(x_pomiar, y_pomiar, x_test)
    % Implementacja metodą z labolatoriów
    n = length(x_pomiar);
    S = length(x_test);
    y_test = zeros(1, S);

    for i = 1:S
        x = x_test(i);
        suma = 0;
        
        for k = 1:n
            licznik = 1;
            mianownik = 1;
            for j = 1:n
                if j ~= k
                    licznik = licznik * (x - x_pomiar(j));
                    mianownik = mianownik * (x_pomiar(k) - x_pomiar(j));
                end
            end
            lk = licznik / mianownik;
            suma = suma + lk * y_pomiar(k);
        end
        y_test(i) = suma;
    end
end
