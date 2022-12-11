function trajectory = followGradient(p,gradient)
    %Inputs: p - starting position (js), gradient - gradient that you want to follow
    %Outputs: trajectory - overall trajectory after following gradient
    trajectory(1,:) = p;
    i =2;
    e = 0.02*(0.15-0028);
    while(norm(p-goalTheta)>e) %Set precision based on theta3 bounds
        row = findClosest(p,gradient);
        p = p + gradient(row,5:7);
        trajectory(i,:) = p;
        i = i+1;
    end
end

function row = findClosest(p,gradient)
    tol = 10000;
    for i = 1:length(gradient(:,1))
        if norm(gradient(i,1:3)-p) < tol
            row = i;
            tol = norm(gradient(i,1:3));
        end
    end
end