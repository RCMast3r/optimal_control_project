close all;
hold on;
clear;
% actual:
% dt = .001;
% testing:
dt = 0.001;
N = 6;
C = 1;
K = 1;
alpha = 0.25;
beta = 0.25;
Num_interations = 100;

final_time = 20;
time_vec = 0:dt:final_time;
final_sample = (final_time/dt)+1;
initial_u = zeros(2*N, length(time_vec));
J_values = ones(1,Num_interations + 1);

% TODO plot all u's over time as well
% TODO plot resulting phase plot of all the states

% TODO
u = initial_u;

iteration_ind = 0;

while(iteration_ind <= Num_interations)
    % step 1
    state = GetState(u, time_vec, dt, N);
    %plot(state(3, 1), state(4, 1), '.', 'MarkerSize', 30)
    %plot(state(5, 1), state(6, 1), '.', 'MarkerSize', 30)
    %plot(state(7, 1), state(8, 1), '.', 'MarkerSize', 30)
    %plot(state(9, 1), state(10, 1), '.', 'MarkerSize', 30)
    %plot(state(11, 1), state(12, 1), '.', 'MarkerSize', 30)
    %plot(state(13, 1), state(14, 1), '.', 'MarkerSize', 30)

    %plot_all(state, u)
    costate = GetCostate(state, time_vec, dt, N);
    % step 2
    minimized_controls = GetHamiltonianMinimizer(costate, N);

    theta_res = GetThetaGap(minimized_controls, u, costate, state, dt, N);
    
    v = minimized_controls;
    % step 3
    if(iteration_ind>1)
        k_u = k_u - 2;
    else
        k_u =0;
    end
    
    beta_k_scaled_cost = u + ((beta^k_u) * (v - u));

    test_state = GetState(beta_k_scaled_cost, time_vec, dt, N);
    
    J_beta = GetCost(test_state, beta_k_scaled_cost, time_vec, dt, N);
    J_u = GetCost(state, u, time_vec, dt, N);
    J_values(1,iteration_ind+1) = J_u;
    gap_scaled = (alpha * (beta^k_u) * theta_res);
    cost_diff = (J_beta - J_u);
    while( cost_diff > gap_scaled)
        k_u = k_u +1;
        gap_scaled = (alpha * (beta^k_u) * theta_res);
        test = ((beta^k_u) * (v - u));
        beta_k_scaled_cost = u + test;

        test_state = GetState(beta_k_scaled_cost, time_vec, dt, N);
        
        J_beta = GetCost(test_state, beta_k_scaled_cost, time_vec, dt, N);
        J_u = GetCost(state, u, time_vec, dt, N);
        cost_diff = (J_beta - J_u);
    end

    u_next = u + ((beta^k_u) * (v - u));

    u = u_next;
    iteration_ind = iteration_ind + 1;

end

J_values(1,iteration_ind) = GetCost(state, u, time_vec, dt, N);




plot(state(1, 1), state(2, 1), '.', 'MarkerSize', 15)
text(state(1, 1), state(2, 1), 'x_{0}', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
plot([state(3, 1) state(3, final_sample)], [state(4, 1) state(4, final_sample)], '.', 'MarkerSize', 15)
text(state(3, 1), state(4, 1) , 'x_{1}(0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(state(3, final_sample), state(4, final_sample) , 'x_{1}(20)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
plot([state(5, 1) state(5, final_sample)], [state(6, 1) state(6, final_sample)], '.', 'MarkerSize', 15)
text(state(5, 1), state(6, 1), 'x_{2}(0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(state(5, final_sample), state(6, final_sample) , 'x_{2}(20)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
plot([state(7, 1) state(7, final_sample)], [state(8, 1) state(8, final_sample)], '.', 'MarkerSize', 15)
text(state(7, 1), state(8, 1), 'x_{3}(0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(state(7, final_sample), state(8, final_sample) , 'x_{3}(20)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
plot([state(9, 1) state(9, final_sample)], [state(10, 1) state(10, final_sample)], '.', 'MarkerSize', 15)
text(state(9, 1), state(10, 1), 'x_{4}(0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(state(9, final_sample), state(10, final_sample) , 'x_{4}(20)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
plot([state(11, 1) state(11, final_sample)], [state(12, 1) state(12, final_sample)], '.', 'MarkerSize', 15)
text(state(11, 1), state(12, 1), 'x_{5}(0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(state(11, final_sample), state(12, final_sample) , 'x_{5}(20)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
plot([state(13, 1) state(13, final_sample)], [state(14, 1) state(14, final_sample)], '.', 'MarkerSize', 15)
text(state(13, 1), state(14, 1), 'x_{6}(0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(state(13, final_sample), state(14, final_sample) , 'x_{6}(20)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
plot([state(15, 1) state(15, final_sample)], [state(16, 1) state(16, final_sample)], '.', 'MarkerSize', 15)
text(state(15, 1), state(16, 1), 'x_{7}(0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(state(15, final_sample), state(16, final_sample) , 'x_{7}(20)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

ylim([-5 5]);  
xlim([-1 30]);

title('Phase Portraits of x_{0} through x_{7}')

%legend('x_{1}','x_{2}','x_{3}','x_{4}','x_{5}','x_{6}','x_{7}');


plot_all(state, u)

figure;
plot(0:Num_interations,J_values);
title('Cost vs Iterations');
