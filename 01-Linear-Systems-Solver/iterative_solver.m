function x = iterative_solver(A, b)
    % metoda Gaussa-Seidla
    n = length(b);
    x = zeros(n,1);
    maxIter = 100;
    tolerance = 1e-6; 
    
    for k = 1:maxIter
        x_old = x; 
        for i = 1:n
            x(i) = (b(i) -(A(i, :) * x - A(i, i)*x(i))) / A(i, i);
            %zamieniając x na x_old otrzymujemy metodę Jacobiego
         end
       
         if norm(x - x_old, inf) < tolerance
            %fprintf('Metoda iteracyjna zbieżna po %d iteracjach.\n', k);
            return;
         end
    end
    warning('Osiągnięto limit iteracji bez pełnej zbieżności.');
end
