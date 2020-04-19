function out = inSensorRange(agent, obstacle)
% inSensorRange - Returns true if the obstalce is in sensor range
%
% Syntax: out = inSensorRange(agent, obstacle)
%
    distance = sum((agent.position - obstacle.position).^2) < agent.sensorRange^2;
    sameSide = (agent.position - obstacle.position) * (agent.velocity - obstacle.velocity)' < 0;
    out = distance && sameSide;
end