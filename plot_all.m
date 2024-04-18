function plot_all(states, inputs)
    for i=1:2:12
        plot(states(i+1, :), states(i, :))
    end
end