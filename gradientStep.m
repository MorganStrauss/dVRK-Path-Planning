function [step] = gradientStep(q,P,output)
    %Inputs: 
    % q: current position [theta1; theta2;theta3]
    % P: matrix with each row a different configuration containing:
        % theta1 
        % theta2 
        % theta3 
        % Potential Gradient 
        % theta1 index
        % theta2 index
        % theta3 index
    % x_vals: vector of values for theta1
    % y_vals: vector of values for theta2
    % z_vals: vector of values for theta3
    % output: 0 for no output, 1 to get output statements for debugging
    adj = [-1 0 1];
    %Find current location and potential:
    x = find(x_vals>=q(1),1,'first');
    y = find(y_vals>=q(2),1,'first');
    z = find(z_vals>=q(2),1,'first');
    P_curr = P(x,y,z);
    if output
        disp(['P_curr is ' num2str(P_curr) ' at: ' num2str(x_vals(x)) ', ' num2str(y_vals(y)) ', ' num2str(z_vals(z)) ' index: ' num2str(x) ', ' num2str(y) ', ' num2str(z)])
    end
    %Create temporary values for comparison:
    x_new  = x;
    y_new = y;
    P_step = P_curr;
    for i=1:3
       for j=1:3
           for h=1:3
               if output
                 disp(['Adjacent Potential of: ' num2str(P(x+adj(i),y+adj(j))) ' at: ' num2str(x_vals(x+adj(i))) ', ' num2str(y_vals(y+adj(j))) ', ' num2str(z_vals(z+adj(h)))])
               end
               if(P(x+adj(i),y+adj(j),z+adj(h)) < P_step)
                   x_new = x+adj(i);
                   y_new = y+adj(j);
                   z_new = z+adj(h);
                   P_step = P(x_new,y_new,z_new);
               end
           end
       end
    end
    
    if x_new~=x || y_new~=y || z_new~=z
        x = x_new;
        y = y_new;
        z=z_new;
        step = [x_vals(x); y_vals(y); z_vals(z)]-q;
        if output
            disp(['P_step is ' num2str(P(x,y)) ' at: ' num2str(x_vals(x)) ', ' num2str(y_vals(y)) ', ' num2str(z_vals(z)) ' index: ' num2str(x) ', ' num2str(y) ', ' num2str(z)])
            disp(['Current Position: ' num2str(q(1)) ', ' num2str(q(2)) ' moving to: ' num2str(x_vals(x)) ', ' num2str(y_vals(y)) ', ' num2str(z_vals(z))])
            disp(['Stepping by: ' num2str(step(1)) ', ' num2str(step(2))])
            fprintf('\n')
        end
        return;
    end
    disp('Lowest potential found')
    step = [0; 0; 0];
end