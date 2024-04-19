%TODO finish
function p_result = GetCostate(x_vec_over_time, time_vec, dt, N)
% x_vec_over_time is in (2*N) + 4 x number of time steps still since
% we do still need to take into account x_0 and x_7 for the running
% cost partial derivative (dL_dx).
    p_result = zeros((2*N), length(time_vec));

    dL_dx_over_time = zeros(2*N, length(time_vec));
    
    % x_vec_over_time has x0 through x7
    % this for loop calculates the partial derivative of L w.r.t. x at each
    % time t. dL_dx_j is a matrix in 2x(number of dts)
    for j = 3:2:(2*(N+1))
        % TODO check the index math here
        
        x_j_prev = x_vec_over_time((j-2):(j-1), :);
        x_j_next = x_vec_over_time((j+2):(j+3), :);
        x_j = x_vec_over_time(j:(j+1), :);
        
        dL_dx_j = -2*((2*x_j) -x_j_prev - x_j_next);
        


        % Perform the replacement
        dL_dx_over_time((j-2):(j-1), :) = dL_dx_j;
    end
    
    for t = length(time_vec)-1:-1:1
        p_result(:, t) = -1 * dt*dL_dx_over_time(:, t) + p_result(:, t+1);
    end

    %TODO 

end