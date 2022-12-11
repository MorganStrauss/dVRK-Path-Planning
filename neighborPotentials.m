function [neighborP] = neighborPotentials(field,row,n)
    for i =-1:2:1 %Go forward and backward in x:
         currentRow = row+(n^2*i);
         P_new = field(currentRow,4);
         neighborP(0.5*i+1.5,1) = p_new;
    end
    for i =-1:2:1 %Go forward and backward in y:
        currentRow = row+n*i;
        P_new = field(currentRow,4);
        neighborP(0.5*i+1.5,2) = p_new;
    end
    for i =-1:2:1 %Go forward and backward in z:
        currentRow = row+i;
        P_new = field(currentRow,4);
        neighborP(0.5*i+1.5,3) = p_new;
    end
end