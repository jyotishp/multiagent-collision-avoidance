function position = futurePosition(agent, dt)
%futurePosition - Returns the future position from the current velocity
%
% Syntax: position = futurePosition(agent, dt)
%
    position = agent.position + agent.newControl*dt;
end