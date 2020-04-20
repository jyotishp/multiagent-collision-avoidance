function smoothenedControls = smoothenControls(agent, control)
%smoothenControls - Smoothen controls to satisfy kinematic constraints
%
% Syntax: smoothenedControls = smoothenControls(agent, control)
%
    w = 0.5;
    smoothenedControls = ((1-w)*agent.velocity + w*control);
end