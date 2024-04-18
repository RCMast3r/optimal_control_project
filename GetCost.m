function J = GetCost(x, u, time_vec, dt, N)
    J = 0;
    for t = 1:length(time_vec)
        J = J + GetRunningCost(x(:, t), u(:, t), N);
    end
end
