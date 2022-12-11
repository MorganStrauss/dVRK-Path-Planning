function trajectory = followGradient(p,gradient,goalTheta)
    %Inputs: p - starting position (js), gradient - gradient that you want to follow
    %Outputs: trajectory - overall trajectory after following gradient
    i =1;
    e = 0.02*(0.15-0028);
    while(norm(p-goalTheta)>e && i < 100) %Set precision based on theta3 bounds
        trajectory(i,:) = p;
        row = findClosest(p,gradient)
        push = gradient(row,5:7)
        p = p + gradient(row,5:7)
        i = i+1;
    end
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