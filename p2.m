close all;
hold on;
clear;
% actual:
% dt = .001;
% testing:
dt = 1;
N = 6;
C = 1;
K = 1;
alpha = 0.25;
beta = 0.25;

final_time = 20;
time_vec = [0:dt:final_time];
initial_u = zeros(2*N, length(time_vec));

% TODO plot all u's over time as well
% TODO plot resulting phase plot of all the states

% TODO
u = initial_u;

iteration_ind = 0;

while(iteration_ind <= 100)
    % step 1
    state = GetState(u, time_vec, dt, N);

    costate = GetCostate(state, time_vec, dt, N);
    % step 2
    minimized_controls = GetHamiltonianMinimizer(costate, N);

    theta_res = GetThetaGap(minimized_controls, u, costate, state, dt, N);
    if abs(theta_res) < .0001
        break
    end

    v = minimized_controls;
    % step 3
    k_u = 0;
    beta_k_scaled_cost = u + ((beta^k_u) * (v - u));
    
    J_beta = GetCost(state, beta_k_scaled_cost, time_vec, dt, N);
    J_u = GetCost(state, u, time_vec, dt, N);
    gap_scaled = (alpha * (beta^k_u) * theta_res);
    cost_diff = (J_beta - J_u);
    while( cost_diff > gap_scaled)
        k_u = k_u +1;
        test = ((beta^k_u) * (v - u));
        beta_k_scaled_cost = u + test;
        
        J_beta = GetCost(state, beta_k_scaled_cost, time_vec, dt, N);
        J_u = GetCost(state, u, time_vec, dt, N);
        cost_diff = (J_beta - J_u);
    end

    u_next = u + ((beta^k_u) * (v - u));

    u = u_next;
    iteration_ind = iteration_ind + 1;
    
end

plot(state(3, 1), state(4, 1), '.', 'MarkerSize', 30)
plot(state(5, 1), state(6, 1), '.', 'MarkerSize', 30)
plot(state(7, 1), state(8, 1), '.', 'MarkerSize', 30)
plot(state(9, 1), state(10, 1), '.', 'MarkerSize', 30)
plot(state(11, 1), state(12, 1), '.', 'MarkerSize', 30)
plot(state(13, 1), state(14, 1), '.', 'MarkerSize', 30)

plot_all(state, u)
