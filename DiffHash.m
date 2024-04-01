%This function takes in the input - greyscale_image a mxn+1 uint8 array,
%and outputs logical_rvector a mxn logical row vector. The purpose of this 
%function is to go through each pixel in the greyscale image and compare 
%the value to the one directly to the right of it. If the pixel is greater 
%or equal to the one to the right of it a logical 1 value is assigned to 
%the logical_rvector else 0 is asssigned. Once it reaches the nth column 
%and compares it to the n+1 column it moves down to the next row of values 
%and repeats this process until all pixels in the mxn array have been 
%compared.
%
%Author: Kartik Malik
function [logical_rvector] = DiffHash(greyscale_image)
    
    %Predetermines/Pre-allocates values are stored below
    [m,np1] = size(greyscale_image); %m rows and n+1 columns
    logical_rvector = [];
    partial_rvector = zeros(1,(np1-1));
    
    %Determines how the pixels compares to its neighbouring value
    for i = 1:m
        for j = 1:np1-1
            if greyscale_image(i,j) >= greyscale_image(i,j+1)
                partial_rvector(1,j) = 1;
            else
                partial_rvector(1,j) = 0;
            end
        end
        logical_rvector = logical(horzcat(logical_rvector,partial_rvector)); %horizontally concatenates the partial_rvector 
        %repeatedly to the logical_rvector and converts the 1s and 0s from doubles to logical values
    end

end