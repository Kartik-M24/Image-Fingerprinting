%This function takes in two inputs, the input_array - either a 3D or
%2D mxn uint8 array, and desired_dimensions - which is a 1x2 array 
%containing the desired height of the image [1,1] and the desired length 
%[1,2]. This code takes in these inputs and determines the row and column 
%size ratios, it then uses these values and runs through the rows and 
%columns of the desired image to determine the values at each of the pixels 
%in the desired dimensions array. Every value that it determines using the 
%ratio and the current pixel it is in within the desired dimensions is then 
%outputted to the output_array (a mxn uint8 array either 2D or 3D 
%depending on the input). 
%
%Author: Kartik Malik
function [output_array] = ResizeNearest(input_array, desired_dimensions)
    
    %Predetermined/s values are storeed below
    [rows, columns, layers] = size(input_array);
    Rsz_row = desired_dimensions(1,1);
    Rsz_col = desired_dimensions(1,2);
    Rrow = rows/Rsz_row; %row size ratio
    Rcol = columns/Rsz_col; %column size ratio

    if layers == 1 %if its a greyscale image
        output_array = zeros(Rsz_row,Rsz_col); %preallocates greyscale output image
    
        for i = 1:Rsz_row
            for j = 1:Rsz_col
                io = ceil((i-0.5)*Rrow); %determines row value from input_array
                jo = ceil((j-0.5)*Rcol); %determines column value from input_array
                output_array(i,j) = input_array(io,jo); %assigns the pixel value from the greyscale input_array 
                %to the appropriate pixel in the output_array
            end
        end

    elseif layers == 3 %if it's a coloured image 
        output_array = zeros(Rsz_row,Rsz_col,3); %preallocates coloured output image
        
        for i = 1:Rsz_row
            for j = 1:Rsz_col
                io = ceil((i-0.5)*Rrow);
                jo = ceil((j-0.5)*Rcol);
                output_array(i,j,:) = input_array(io,jo,:); %if it's a coloured image the same steps are done except the value
                %in the input_array across all layers are assigned to the appropriate pixel in the output_array across all layers
            end
        end
    end
    
    output_array = uint8(output_array);
end