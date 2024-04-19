function plot_all(states, inputs)
hold on;
    for i=1:2:16

        y = states(i+1, :);
        x = states(i, :);
        
        plot(x, y)
    end
end