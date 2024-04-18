function theta_res = GetThetaGap(v_over_time, u_over_time, p_over_time, x_over_time, N)

    theta_res = 0;
    
    for t = 1:length(u_over_time)
        p = p_over_time(:, t);
        u = u_over_time(:, t);
        v = v_over_time(:, t);
        x = x_over_time(:, t);
        H_u_t = (p.' * u) + GetRunningCost(x, u, N);
        H_v_t = (p.' * v) + GetRunningCost(x, v, N);
        theta_res = theta_res + (H_v_t - H_u_t);
    end
end