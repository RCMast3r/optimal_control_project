function x_result = GetState(u, time_vec, dt, N)
    % time_vec = in 1x(number of time steps) vector of time stamps starting
    % from 0

    % N = from problem
    % u = in (2*N) x (number of time steps)
    % initialize the state vector with all zeros of size 2*N + 4 
    % (added x_0 and x_7 since they are used in cost calc)
    x_result = zeros((2*N) + 4, length(time_vec));
    
    x_0_0 = [0; 0];
    x_1_0 = [1; -1];
    x_2_0 = [2; 2];
    x_3_0 = [13; 3];
    x_4_0 = [14; 1.5];
    x_5_0 = [17; 2];
    x_6_0 = [20; -3];
    x_7_0 = [20; 0];

    x_inits = [x_0_0; x_1_0; x_2_0; x_3_0; x_4_0; x_5_0; x_6_0; x_7_0];
    x_result(:, 1) = x_inits;

    % at each time step t (not including the first time)
    for t = 2:length(time_vec)
        % at each entity index j (starts at 3 since the first two rows 
        % are taken up by the x_0 entity state) 
        for j = 3:2:(2*N)
            % row, row + 1 = the 2 entity state indexes
            % col = time step
            x_result(j, t) = (u(j, t) * dt) + x_result(j, t-1);
            x_result(j+1, t) = (u(j+1, t) * dt) + x_result(j+1, t-1);
        end
        
    end
    
    % create the trajectory of x_7 for the target agent
    x_last_1_p1 = [20 + (0.6 * time_vec(time_vec < 10))];
    x_last_2_p1 = (-0.3 * time_vec(time_vec < 10));
    
    x_last_append_size = length(time_vec) - length(x_last_1_p1);
    x_last_1 = [x_last_1_p1, ones(1, x_last_append_size) * 26 ];
    x_last_2 = [x_last_2_p1, ones(1, x_last_append_size) * -3 ];
    
    x_result( (2*N) + 3, :) = x_last_1;
    x_result( (2*N) + 4, :) = x_last_2;
    
end