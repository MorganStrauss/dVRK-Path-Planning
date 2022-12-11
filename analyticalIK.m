%Analytic Inverse Kinematics for an RRP robot
function thetaMesh = analyticalIK(mesh)
% mesh is a list of points x,y,z nx3
% thetaMesh is the configuration space corresponding to each point
% Theta 3 Prismatic Offset
pOffset = .013; % mm 
    thetaMesh = zeros(length(mesh(:,1)),3);
    for i = 1:1:length(mesh(:,1))
        p = mesh(i,:)';
        T = getTOrthogonal(p);
        eul = rotm2eul(T(1:3,1:3),'XYZ');
        th3 = norm(p)+pOffset; %because S3 is defined as negative 
        thetaList = [[eul(1) pi-eul(2)] th3];
        % simplify Angle, maybe not needed
        for g = 1:1:length(thetaList)
            if thetaList(g)>pi
                thetaList(g) = thetaList(g)-2*pi; end
            if thetaList(g)<-pi
                    thetaList(g) = thetaList(g)+2*pi; end 
        end 
        % Forward Kinematics to Check Validity
        thetaMesh(i,:) = thetaList(1:3);
    end 
end 

%Get a transform matrix orthogonal to and at a vector tip
function Torthogonal = getTOrthogonal(origin)
    z = (origin/norm(origin));
    x = cross([0 0 1]',z);
    x = x/norm(x);
    y = cross(z,x);
    y = y/norm(y);
    orientation = [x y z];
    Torthogonal = [orientation,origin ; [0 0 0 1]];
end