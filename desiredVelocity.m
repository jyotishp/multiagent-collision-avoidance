function velocity = desiredVelocity(agent)
%desiredVelocity - Get the desired velocity for the agent
%
% Syntax: velocity = desiredVelocity(agent)
%
    velocity = agent.goal - agent.position;
    % If we are already close to the goal, go slower
    if sum(velocity.^2) > agent.vmax^2
        velocity = velocity * agent.vmax / norm(velocity);
    end
end