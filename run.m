%% Clear workspace
clc;
clear all;
close all;

%% Declare the agents
% Usage: addAgent(name, initialPosition, initialVelocity, goal)
agents = [
    addAgent('1', [-5 -5], [0 0], [5 5]),
    addAgent('2', [5 5],   [0 0], [-5 -5]),
    addAgent('3', [-5 5],  [0 0], [5 -5]),
    addAgent('4', [5 -5],  [0 0], [-5 5])
];
axisLimits = [-6 6 -6 6]; % [xmin xmax ymin ymax] axis limits of the plot
dt = 0.1;

%% Simulation loop
% Runs till the distance to goal of all the agents is less than 0.32m
% Or for max iterations
maxIterations = 500;
counter = 0;
while counter < maxIterations
    maxDistFromGoal = 0;
    % Get the new velocity command for every agent but do not update it now
    for i = 1:length(agents)
        % Get agents in the sensor range
        obstacles = [];
        for j = 1:length(agents)
            if i ~= j
                if inSensorRange(agents(i), agents(j))
                    obstacles = [obstacles; agents(j)];
                end
            end
        end
        % Get the new control for the agent
        agents(i).newControl = getControls(agents(i), obstacles, dt);
    end

    % Update the positions of all the agents using the newly obtained controls
    % This is equivalent to running the same algorithm simultaneously on all agents
    for i = 1:length(agents)
        agents(i).path = [agents(i).path; agents(i).position];
        agents(i).position = futurePosition(agents(i), dt);
        agents(i).velocity = agents(i).newControl;
        maxDistFromGoal = max(maxDistFromGoal, sum((agents(i).position - agents(i).goal).^2));
    end

    % Plot the current simulation step
    % Usage: plotSimulation(agents, counter, dt, axisLimits, true) -> Save the outputs to disk
    %        plotSimulation(agents, counter, dt, axisLimits, false) -> Don't save the outputs to disk
    plotSimulation(agents, counter, dt, axisLimits, true);

    counter = counter + 1;

    % Stop running of the goal is reached
    if maxDistFromGoal < 0.1
        break
    end
end