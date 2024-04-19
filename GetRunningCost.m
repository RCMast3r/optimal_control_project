function L = GetRunningCost(x_vec, u, N)
% x_vec is in (2*N) + 4. the current state at time t
% u is in 2*N and is the current input at time t
    L = 0;

    % cost of the x_0 through x_6 entity states and the entity control
    % inputs

    for j = 1:2:(2*N)
        L = L +norm(u(j:j+1));
    end
    
    for j = 3:2:(2*N)
        x_j_prev = x_vec((j-2):(j-1));
        x_j = x_vec(j:j+1);
        L = L + (norm(x_j - x_j_prev)^2);
    end

    % add the cost of the last (x_7 / N+1)
    x_second_to_last = x_vec( 13 : 14 );
    x_last = x_vec( 15 : 16 );

    L = L + (norm(x_last - x_second_to_last)^2);
end