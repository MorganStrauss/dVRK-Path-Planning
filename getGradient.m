function newField = getGradient(field,n)
    %Inputs: field - 7 column matrix with columns of:
        % theta1, theta2, theta3, Potential, and x,y,z index
        dx = field(n^2+1,1) - field(1,1);
        dy = field(n+1,2) - field(1,2);
        dz = field(2,3) - field(1,3);
    for i = 1:length(field(:,1))
        currentP = field(i,4);
        neighborP = neighborPotentials(field,i,n);
        xGradient(i,1) = (neighborP(1,1)-currentP+currentP-neighborP(2,1))/(2*dx);
        yGradient(i,1) = (neighborP(1,2)-currentP+currentP-neighborP(2,2))/(2*dy);
        zGradient(i,1) = (neighborP(1,3)-currentP+currentP-neighborP(2,3))/(2*dz);
    end
    newField = [field(:,1:4) xGradient yGradient zGradient field(:,5:7)];
    quiver3(newField(:,1),newField(:,2),newField(:,3),newField(:,5),newField(:,6),newField(:,7),'r')
end

