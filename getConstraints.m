function [c ceq] = getConstraints(agent, obstacles, control, dt)
%getConstraints - Description
%
% Syntax: [c ceq] = getConstraints(agent, obstacles)
%
    c = [];
    ceq = [];

    % Time horizon
    tau = 0.8;

    for i = 1:length(obstacles)
        % Refer the paper for explanation on these terms
        vRel = agent.velocity - obstacles(i).velocity;
        vAb = agent.velocity + obstacles(i).velocity;
        pAb = (agent.position - obstacles(i).position) / tau;

        % Finding pAb perpendicular
        r = 2 / tau;
        l = abs(sqrt(sum(pAb.^2) - r^2));
        m = [
            l -r;
            r  l
        ];
        qL = (pAb * m') * (l / sum(pAb.^2));
        qR = (pAb * m ) * (l / sum(pAb.^2));
        pAbL = [qL(2) -qL(1)];
        pAbR = [qR(2) -qR(1)];

        c(end+1) = -1*(2*control(1)*(pAbR(1)) + 2*control(2)*(pAbR(2)) - (pAbR(1))*(agent.velocity(1)) - (pAbR(2))*(agent.velocity(2)) - (pAbR(1))*(obstacles(i).velocity(1)) - (pAbR(2))*(obstacles(i).velocity(2)));

        c(end+1) = -1*(2*control(1)*(pAbL(1)) + 2*control(2)*(pAbL(2)) - (pAbL(1))*(agent.velocity(1)) - (pAbL(2))*(agent.velocity(2)) - (pAbL(1))*(obstacles(i).velocity(1)) - (pAbL(2))*(obstacles(i).velocity(2)));

        % Choosing the constrain based on the same side contraint
        % Refer paper for more details
        if det([pAb; vRel]) < 0
            c(end+1) = -1*(control(1)*(pAbR(1))^2*(agent.velocity(1)) + control(2)*(pAbR(1))*(pAbR(2))*(agent.velocity(1)) - 0.5*(pAbR(1))^2*(agent.velocity(1))^2 + control(1)*(pAbR(1))*(pAbR(2))*(agent.velocity(2)) + control(2)*(pAbR(2))^2*(agent.velocity(2)) - 1.*(pAbR(1))*(pAbR(2))*(agent.velocity(1))*(agent.velocity(2)) - 0.5*(pAbR(2))^2*(agent.velocity(2))^2 - control(1)*(pAbR(1))^2*(obstacles(i).velocity(1)) - control(2)*(pAbR(1))*(pAbR(2))*(obstacles(i).velocity(1)) + 0.5*(pAbR(1))^2*(obstacles(i).velocity(1))^2 - control(1)*(pAbR(1))*(pAbR(2))*(obstacles(i).velocity(2)) - control(2)*(pAbR(2))^2*(obstacles(i).velocity(2)) + 1.*(pAbR(1))*(pAbR(2))*(obstacles(i).velocity(1))*(obstacles(i).velocity(2)) + 0.5*(pAbR(2))^2*(obstacles(i).velocity(2))^2);
        else
            c(end+1) = -1*(control(1)*(pAbL(1))^2*(agent.velocity(1)) + control(2)*(pAbL(1))*(pAbL(2))*(agent.velocity(1)) - 0.5*(pAbL(1))^2*(agent.velocity(1))^2 + control(1)*(pAbL(1))*(pAbL(2))*(agent.velocity(2)) + control(2)*(pAbL(2))^2*(agent.velocity(2)) - 1.*(pAbL(1))*(pAbL(2))*(agent.velocity(1))*(agent.velocity(2)) - 0.5*(pAbL(2))^2*(agent.velocity(2))^2 - control(1)*(pAbL(1))^2*(obstacles(i).velocity(1)) - control(2)*(pAbL(1))*(pAbL(2))*(obstacles(i).velocity(1)) + 0.5*(pAbL(1))^2*(obstacles(i).velocity(1))^2 - control(1)*(pAbL(1))*(pAbL(2))*(obstacles(i).velocity(2)) - control(2)*(pAbL(2))^2*(obstacles(i).velocity(2)) + 1.*(pAbL(1))*(pAbL(2))*(obstacles(i).velocity(1))*(obstacles(i).velocity(2)) + 0.5*(pAbL(2))^2*(obstacles(i).velocity(2))^2);
        end
    end

    % Kinematic constraints
    % delVel = agent.velocity - control;
    % c(end+1) = abs(atan2(delVel(2), delVel(1))) - pi/20;
end