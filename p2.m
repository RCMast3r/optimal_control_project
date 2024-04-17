close all;
clear;
dt = 0.001;
N = 6;
C = 1;
K = 1;

final_time = 20;
time_vec = [0:dt:final_time];

% create the trajectory of x_7 for the target agent



plot(x_7_1, x_7_2);

x_7 = [x_7_1; x_7_2];



% TODO plot all u's over time as well
% TODO plot resulting phase plot of all the states

function J = GetCost(x, u, time_vec, dt, N)
    
end

function x_result = GetState(u, time_vec, dt, N)
    % initialize the state vector with all zeros of size 2*N + 4 
    % (added x_0 and x_7 since they are used in cost calc)
    x_res = zeros((2*N) + 4, length(time_vec));
    
    x_0_0 = [0; 0];
    x_1_0 = [1; -1];
    x_2_0 = [2; 2];
    x_3_0 = [13; 3];
    x_4_0 = [14; 1.5];
    x_5_0 = [17; 2];
    x_6_0 = [20; -3];
    x_7_0 = [20; 0];

    x_inits = [x_0_0; x_1_0; x_2_0; x_3_0; x_4_0; x_5_0; x_6_0; x_7_0];
    x_res(:, 1) = x_inits;

    % at each time step t (not including the first time)
    for t = 2:length(time_vec)
        % at each entity index j
        for j = 1:2:(2*N)
            % row, row + 1 = the 2 entity state indexes
            % col = time step
            x_res(j, t) = (u(t) * dt) + x_res(j, t-1);
            x_res(j+1, t) = (u(t) * dt) + x_res(j+1, t-1);
        end
        
    end
    x_last_1_p1 = [20 + (0.6 * time_vec(time_vec < 10))];
    x_last_2_p1 = (-0.3 * time_vec(time_vec < 10));
    
    x_last_append_size = length(time_vec) - length(x_7_1_p1);
    x_last_1 = [x_last_1_p1, ones(1, x_last_append_size) * 26 ];
    x_last_2 = [x_last_1_p1, ones(1, x_last_append_size) * -3 ];

    
end

function p_result = GetCostate(x_vec_over_time, time_vec, dt, N)
    dL_dx_over_time = zeros(size(x_vec_over_time));
    
    % x_vec_over_time has x0 through x7
    % this for loop calculates the partial derivative of L w.r.t. x at each
    % time t. dL_dx_j is a matrix in 2x(number of dts) 
    for j = 1:2:(2*N)
        x_j = x_vec_over_time(j:(j+1), :);
        dL_dx_j = -1*((4*x_j) - (2*x_j_prev) - (2*x_j_next));
        % Specify the starting row index in dL_dx_over_time where dL_dx_j should be inserted
        startRow = j;
        % Calculate the ending row based on the number of rows in dL_dx_j
        endRow = startRow + size(dL_dx_j, 1) - 1;
        
        % Check if the replacement is within the bounds of dL_dx_over_time and columns match
        if endRow > size(dL_dx_over_time, 1) || size(dL_dx_j, 2) ~= size(B, 2)
            error('Replacement out of bounds or column mismatch between dL_dx_over_time and dL_dx_j.');
        end
        
        % Perform the replacement
        dL_dx_over_time(startRow:endRow, :) = dL_dx_j;
    end
    

    %TODO 

end
