function metrics = calculate_metrics(y_real, y_obl)

    y_real = y_real(:); y_obl = y_obl(:);

    % 1. Root Mean Square Error
    rmse = mean((y_real - y_obl).^2);
    metrics.rmse = sqrt(rmse);

    % 2. Mean Absolute Error
    metrics.mae = mean(abs(y_real - y_obl));

    % 3. Współczynnik determinacji 
    ss_res = sum((y_real - y_obl).^2);
    ss_tot = sum((y_real - mean(y_real)).^2);
    metrics.r2 = 1 - (ss_res / ss_tot);
end