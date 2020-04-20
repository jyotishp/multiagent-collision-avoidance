function controls = getControls(agent, obstacles, dt)
%getControls - Returns the controls that will avoid collision
%
% Syntax: controls = getControls(agent, obstacles, dt)
%
    cost = @(u) desiredVelocityCost(agent, u') + 0.5*sum((agent.velocity - u').^2);
    constraints = [];
    if length(obstacles) > 0
        constraints = @(u) getConstraints(agent, obstacles, u', dt);
    end
    init = agent.velocity' * 0.5;
    lb = [-1.2 -1.2];
    ub = [1.2 1.2];
    options = optimoptions('fmincon','Display','final-detailed','Algorithm','sqp');
    controls = fmincon(cost, init, [], [], [], [], lb, ub, constraints, options)';

    % Smoothen the controls
    controls = smoothenControls(agent, controls);
end