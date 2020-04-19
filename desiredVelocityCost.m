function cost = desiredVelocityCost(agent, control)
%desiredVelocityCost - Deviation from the desired velocity
%
% Syntax: cost = desiredVelocityCost(agent, control)
%
    cost = sum((desiredVelocity(agent) - control).^2);
end