close all;
clear;
dt = 1;
N = 6;
C = 1;
K = 1;

final_time = 20;
time_vec = [0:dt:final_time];
initial_u = ones(2*N, length(time_vec));

% TODO plot all u's over time as well
% TODO plot resulting phase plot of all the states

% TODO

state = GetState(initial_u, time_vec, dt, N)
costate = GetCostate(state, time_vec, dt, N)
minimized_controls = GetHamiltonianMinimizer(costate, N)
% TODO handle the point-wise minimization of the hamiltonian
% TODO get the hamiltonian gap
