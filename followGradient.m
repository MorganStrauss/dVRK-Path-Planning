function trajectory = followGradient(startTheta,gradientField,goalTheta)
    %Inputs: p - starting position (js), gradient - gradient that you want to follow
    %Outputs: trajectory - overall trajectory after following gradient
    i =1;
    e = 0.02*(0.15-0028);
    while(norm(startTheta-goalTheta)>e && i < 100) %Set precision based on theta3 bounds
        if abs(startTheta(1)) > max(gradientField(:,1)) || abs(startTheta(2)) > max(gradientField(:,2)) || startTheta(3) > max(gradientField(:,3)) || startTheta(3) < min(gradientField(:,3))
            error('Trajectory lead out of bounds')
        end
        trajectory(i,:) = startTheta';
        row = findClosest(startTheta,gradientField);
        push = gradientField(row,5:7)';
        startTheta = startTheta + gradientField(row,5:7)';
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