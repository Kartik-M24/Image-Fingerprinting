%This function takes in two inputs f1 and f2 which are both 1xn logical row
%vectors. The purpose of this function is to compare f1 and f2 across each
%column to see how many values are different at the same positions between
%f1 and f2. As it goes through the entire row vector, it determines the
%total number of differences between the two row vectors, this value is
%assigned to the output - num_differences - which is an integer.
%
%Author: Kartik Malik
function [num_differences] = HammingDistance(f1,f2)
    
    %Predetermines/Pre-allocates values are stored below
    [~,n] = size(f1);
    num_differences = 0;
    f1 = string(f1);
    f2 = string(f2);
    
    %Goes through each individual value of the two row vectors and compares
    %them to see if they are the same, if not num_differences increases by 1
    for i = 1:n
        value = strcmp(f1(i),f2(i));
        if value == 0
            num_differences = num_differences + 1;
        end
    end

end