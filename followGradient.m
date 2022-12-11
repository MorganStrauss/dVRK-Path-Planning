function trajectory = followGradient(startTheta,gradient,goalTheta)
    %Inputs: p - starting position (js), gradient - gradient that you want to follow
    %Outputs: trajectory - overall trajectory after following gradient
    i =1;
    e = 0.02*(0.15-0028);
    while(norm(startTheta-goalTheta)>e && i < 100) %Set precision based on theta3 bounds
        trajectory(i,:) = startTheta;
        row = findClosest(startTheta,gradient);
        startTheta = startTheta + gradient(row,5:7)';
        i = i+1;
    end
    save('Trajectory.mat','trajectory')
end

function row = findClosest(p,gradient)
    tol = 10000;
    for i = 1:length(gradient(:,1))
        if norm(gradient(i,1:3)-p) < tol
            row = i;
            tol = norm(gradient(i,1:3)-p);
        end
    end
end