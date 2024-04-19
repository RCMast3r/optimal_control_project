function v_over_time = GetHamiltonianMinimizer(costate_vec_over_time, N)
    % iterate through all of the costates (p) throughout time get the
    % point-wise minimizing control v
    v_over_time = zeros(2*N, length(costate_vec_over_time));

    for i = 1:length(costate_vec_over_time)
        % at each entity we will check the different conditions of the
        % costate for the minimizing control
        for j = 1:2:(2*N)
            % v_1 and v_2 are the control variables associated with each of
            % the entity costates
            p_x = costate_vec_over_time(j, i);
            p_y = costate_vec_over_time(j+1, i);
            [phi, q] = cart2pol(p_x, p_y);

            r = 0;
            theta = 0;
            if(q > 1)
                r = 1;
                theta = pi - phi;
            end
            [v_1, v_2] = pol2cart(theta, r);

            v_over_time(j, i) = v_1;
            v_over_time(j+1, i) = v_2;
        end
    end
end
