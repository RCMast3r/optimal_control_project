function plot_all(states, inputs)
hold on;
    for i=1:2:16
        plot(states(i, :), states(i+1, :))
    end
end