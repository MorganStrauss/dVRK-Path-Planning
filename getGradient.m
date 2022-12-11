function newField = getGradient(field,n)
    %Inputs: field - 7 column matrix with columns of:
        % theta1, theta2, theta3, Potential, and x,y,z index
        gradient = zeros(length(field),3);
    for i = (n+n^2+2):(n-2)*n^2+(n-2)*n+(n-1)
        gradient(i,:) = nearestNeighbor(field,i,n);
    end
    newField = [field(:,1:4) gradient field(:,5:7)];
end

function [gradient] = nearestNeighbor(field,row,n)
    theta1 = field(row,1);
    theta2 = field(row,2);
    theta3 = field(row,3);
    P = field(row,4);
    P_curr = P;
    gradient = [0 0 0]; %Gradient if no surrounding potential is lower
    for i =-1:1
      for j=-1:1
          for h = -1:1
              currentRow = row+(n^2*i)+n*j+h;
              theta1_new = field(currentRow,1);
              theta2_new = field(currentRow,2);
              theta3_new = field(currentRow,3);
              P_new = field(currentRow,4);
              if P_new < P_curr
                  gradient = (P_new-P)./[theta1_new-theta1,theta2_new-theta2,theta3_new-theta3];
                  P_curr = P_new;
              end
          end
      end
    end
end