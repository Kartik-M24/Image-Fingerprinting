%This function takes in two inputs, input_array - a mxnxp uint8 array which
%is either a greyscale image (if p = 1) or a colour image (if p = 3); and 
%resize_dimension - a 1x2 double array [i j] containing the desired new 
%height i and the desired new width j. The purpose of this function is to
%resize the inputted image into a new image with the desired dimensions.
%This is done through the usage of the box sampling algorithm. How this
%code works is it takes in the inputted image and disects it into smaller
%boxes (where each box is one pixel in the outputted array). It then works
%out the average value (rounded) of the pixels within each box of the 
%input_array, this is then assigned to the output - resized_array a ixjxp 
%uint8 array. Note that in colour image the average pixel value is 
%calculated across each layer of colour and then the average red green and 
%blue values are assigned to the outputted pixel.
%
%Author: Kartik Malik
function [resized_array] = ResizeBox(input_array, resize_dimensions)
    
    %Predetermines/Pre-allocates values are stored below
    Rsz_height = resize_dimensions(1,1);
    Rsz_width = resize_dimensions(1,2);
    [rows, columns, layers] = size(input_array);
    box_size = [rows/Rsz_height, columns/Rsz_width]; %the width and length of each box within the array (respectively)
    resized_array = zeros(Rsz_height, Rsz_width);
    input_array = double(input_array); %converts array to double so arithmetic functions can be used normally
   
    %Works out the average value for the pixel in each box of the Image and assigns this to the outputted array
    initial_height = 0;
    for i = 1:Rsz_height
        initial_width = 0;
        for j = 1:Rsz_width

            %Determines list of values for the coordinates within the box where the pixels can be considered.
            height = i*box_size(1,1);
            height_r = round(height); %Rightside of box
            width = j*box_size(1,2);
            width_r = round(width); %Bottomside of box

            %Checks for edge cases where box width/height or both have 0.5 values in them
            %Each if statement has round(x,6), to accounts for rounding errors
            if round(round(initial_width)-initial_width,6) == 0.5 && round(round(initial_height) - initial_height,6) == 0.5
                initialw_rounded = floor(initial_width); %Leftside of box
                initialh_rounded = floor(initial_height); %Topside of box
            elseif round(round(initial_width)-initial_width,6) == 0.5 && round(round(initial_height) - initial_height,6) ~= 0.5
                initialw_rounded = floor(initial_width);
                initialh_rounded = round(initial_height);
            elseif round(round(initial_width)-initial_width,6) ~= 0.5 && round(round(initial_height) - initial_height,6) == 0.5
                initialh_rounded = floor(initial_height);
                initialw_rounded = round(initial_width);
            else
                initialw_rounded = round(initial_width);
                initialh_rounded = round(initial_height);
            end
            
            if layers == 1 %Greyscale Image
                pixel_grp = input_array(initialh_rounded+1:height_r,initialw_rounded+1:width_r); %groups pixels within the ranges
                
                %Determines the average value in the box of pixels and assigns this value to the output array
                average_value_gs = round(mean(pixel_grp, "all"));
                resized_array(i,j) = average_value_gs;

            elseif layers == 3 %Colour Image
                pixel_grp1 = input_array(initialh_rounded+1:height_r,initialw_rounded+1:width_r,1); %groups pixels within the ranges (red layer)
                pixel_grp2 = input_array(initialh_rounded+1:height_r,initialw_rounded+1:width_r,2); %groups pixels within the ranges (green layer)
                pixel_grp3 = input_array(initialh_rounded+1:height_r,initialw_rounded+1:width_r,3); %groups pixels within the ranges (blue layer)

                %Determines the average value in the box of pixels and assigns this value to the output array
                average_value_r = round(mean(pixel_grp1(:,:), "all"));
                average_value_g = round(mean(pixel_grp2(:,:), "all"));
                average_value_b = round(mean(pixel_grp3(:,:), "all"));
                resized_array(i,j,1) = average_value_r;
                resized_array(i,j,2) = average_value_g;
                resized_array(i,j,3) = average_value_b;
            end
            
            initial_width = initial_width + box_size(1,2); %new value for Leftside of box
        end
        initial_height = initial_height + box_size(1,1); %new value for Topside of box
    end
                
    resized_array = uint8(resized_array);

end

