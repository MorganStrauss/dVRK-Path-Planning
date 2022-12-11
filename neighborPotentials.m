function [neighborP] = neighborPotentials(field,row,n)
    P_curr = field(row,4);
    for i =-1:2:1 %Go forward and backward in x:
         currentRow = row+(n^2*i);
         if currentRow < 1 || currentRow > n^3
            P_new = 1.25*P_curr;
         else
            P_new = field(currentRow,4);
         end
         neighborP(0.5*i+1.5,1) = p_new;
    end
    for i =-1:2:1 %Go forward and backward in y:
        currentRow = row+n*i;
        if currentRow < 1 || currentRow > n^3
            P_new = 1.25*P_curr;
        else
            P_new = field(currentRow,4);
        end
        neighborP(0.5*i+1.5,2) = p_new;
    end
    for i =-1:2:1 %Go forward and backward in z:
        currentRow = row+i;
        if currentRow < 1 || currentRow > n^3
            P_new = 1.25*P_curr;
        else
            P_new = field(currentRow,4);
        end
        neighborP(0.5*i+1.5,3) = p_new;
    end
end