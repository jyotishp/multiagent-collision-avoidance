function agent = addAgent(name, position, velocity, goal)
% addAgent - Return a struct with agent details
%
% Syntax: agent = addAgent(name, position, velocity, goal)
%
    agent = struct( 'name', name, 'position', position, 'velocity', velocity );
    agent.goal = goal;
    agent.path = [];
    agent.radius = 0.5;
    agent.sensorRange = 5;
    agent.vmax = 1.5;
end