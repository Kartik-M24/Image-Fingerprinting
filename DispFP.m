%This function takes in one input - logical_rvector which as the name
%suggests is a row vector of logical values. The purpose of this function
%is to format the vector into easier to read and compare structure. The
%structure this function formats the input to is: that every 8 logical
%values are grouped together with a space after it, if there is less than 8
%values in the last group then as many as are left are displayed. The last
%group doesn't have a space following it but a newline at the end. This
%function has no output but should display the formatted structure to the
%workspace this is done by using the fprint function.
%
%Author: Kartik Malik
function DispFP(logical_rvector)

    %Predetermines/Pre-allocates values are stored below
    [~,n] = size(logical_rvector);
    logical_rvector = num2str(double(logical_rvector)); %converts to string to remove whitespaces
    %The following algorithm retrieved from https://www.geeksforgeeks.org/how-to-remove-space-in-a-string-in-matlab/
    logical_rvector = logical_rvector(~isspace(logical_rvector)); %determines if the character is not a space if so it is kept
    groups = floor(n/8); %determines the maximum group of 8s that goes into the logical row vector
    remainder = mod(n,8); %determines the remainder in the last group
    
    %Formats the inputted array values
    if remainder == 0
        for i = 0:groups-1
            if i == groups-1 %if it is the last set of 8 logical values
                fprintf('%s', logical_rvector(1,1+(8*i):8+(8*i)));
            else
                fprintf('%s ', logical_rvector(1,1+(8*i):8+(8*i))); 
            end
        end
        fprintf('\n')

    elseif remainder > 0
        for i = 0:groups-1
            fprintf('%s ', logical_rvector(1,1+(8*i):8+(8*i)));
        end
        fprintf('%s', logical_rvector(1,1+(8*groups):(8*groups)+remainder)); %prints the remaining values in the last group
        fprintf('\n');
    end

end