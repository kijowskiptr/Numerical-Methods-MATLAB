function x = gauss_solver(A, b)
    n = length(b);
    Ab = [A, b]; %Macierz rozszerzona

    for k = 1:n-1
        for w = k+1:n
            L = Ab(w,k) / Ab(k,k); %Mnożnik %Ab(w,k)- wartość pod wektorem bazowym %Ab(k,k) - wartość z przekątnej

            Ab(w, k:n+1) = Ab(w, k:n+1) - L * Ab(k, k:n+1);
        end
    end

    x = zeros(n, 1);

    x(n) = Ab(n, n+1)/Ab(n, n);

    for w = n-1:-1:1
        suma = Ab(w, w+1:n) * x(w+1:n);
        x(w) = (Ab(w, n+1) - suma) / Ab(w,w);
    end


end