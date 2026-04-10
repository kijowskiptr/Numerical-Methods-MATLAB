function x = lu_solver(A, b)
    
    %--------Dekompozycja---------    Koszt O(n^3)
    n = length(b);
    L = eye(n);
    U = A;
    for k = 1:n-1
        for w = k+1:n
            l = U(w,k) / U(k,k);
            L(w,k) = l;
            U(w, k:n) = U(w, k:n) - l * U(k, k:n);
        end
    end

    %--------Rozwiązania-------       Koszt O(n^2)
    y = zeros(n,1);
    y(1) = b(1)/L(1,1);
    for i = 2:n
        y(i) = (b(i) - L(i, 1:i-1) * y(1:i-1))/L(i,i); % b1 - suma, podzielnie przez wartość na przekątnej
    end
    
    x = zeros(n,1);
    x(n) = y(n)/U(n,n);
    for i = n-1:-1:1
        x(i) =(y(i) - U(i, i+1:n) * x(i+1:n)) / U(i,i);

    end

end
