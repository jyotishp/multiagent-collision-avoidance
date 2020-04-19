function plotSimulation(agents, counter, dt, axisLimits, save)
% plotSimulation - Plots the positions of the agents and their paths
%
% Syntax: plotSimulation(agents, counter, dt, axisLimits, save)
%
    clf('reset')
    hold on
    for i = 1:length(agents)
        faceColor = [0 170 255] / 255;
        lineColor = [135 135 135] / 255;
        filledCircle(agents(i).position, agents(i).radius, 1000, faceColor);
        quiver(agents(i).position(1), agents(i).position(2), agents(i).velocity(1), agents(i).velocity(2), 'Color', [0 0 0]);
        plot(agents(i).path(:, 1), agents(i).path(:, 2), 'Color', lineColor);
        text(agents(i).position(1), agents(i).position(2), agents(i).name);
    end
    title([ 'Time: ' num2str(counter*dt) 's' ])
    set(get(gca, 'XLabel'), 'String', 'X [m]');
    set(get(gca, 'YLabel'), 'String', 'Y [m]');
    axis(axisLimits)
    axis equal
    hold off
    drawnow

    if save
        saveas(gcf, ['run/', num2str(counter,'%04.f'), '.png']);
    end
end