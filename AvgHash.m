%This function takes in one input - a mxn uint8 greyscale_image, it takes 
%the average of all the pixel values in the greyscale_image and then 
%compares each individual pixel value in the greyscale image to see if it 
%is greater than or equal to the averaged value or less than the averaged 
%value. If the pixel is >= the average value then a value of 0 is stored in
%the output array, if the pixel is <average value then a value of 0 is 
%stored in the output. Once all values in the greyscale image have been 
%compared and assigned to the output_array there should be a logical row
%vector of 1s and 0s of the size [1, mxn].
%
%Author:Kartik Malik
function [logical_rowvector] = AvgHash(greyscale_image)
    
    %Predetermines/Pre-allocates values are stored below
    [rows, columns] = size(greyscale_image);
    avg_value = round(mean(greyscale_image, "all")); %works out average pixel value in the greyscale_image rounded to the nearest integer
    logical_rowvector = [];
    partial_rowvector = zeros(1,columns);
    
    %Determines how the pixels compares to the average value
    for i = 1:rows
        for j = 1:columns
            if avg_value <= greyscale_image(i,j)
                partial_rowvector(1,j) = 1; %assigns true
            elseif avg_value > greyscale_image(i,j)
                partial_rowvector(1,j) = 0; %assigns false
            end
        end
        logical_rowvector = logical(horzcat(logical_rowvector,partial_rowvector)); %horizontally concatenates the partial_rowvector 
        %repeatedly to the logical_rowvector and converts the 1s and 0s from doubles to logical values
    end

end