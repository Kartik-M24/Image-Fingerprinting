%This function takes in the input colour_image a 3D (mxnx3) uint8 array and
%converting it to a greyscale image (mxnx1). It does so by going through
%each pixel of the colour image and using the Luma weighted sum formula to 
%convert the r,g,b values of the pixel according to the formula. This pixel
%is then outputted to the greyscale_image (uint8 array) until every pixel 
%is converted.
%
%Author:Kartik Malik
function [greyscale_image] = GreyscaleLuma(colour_image)

    [rows, columns, ~] = size(colour_image);
    greyscale_image = zeros(rows,columns); %Pre-allocaes the greyscale image

    for i = 1:rows
        for j = 1:columns
            %Determines the r,g,b values of the colour image and converts
            %it a double so arithmetic functions can work normally
            r_value = double(colour_image(i,j,1));
            g_value = double(colour_image(i,j,2));
            b_value = double(colour_image(i,j,3));

            grey_pixel = 0.2126*r_value + 0.7152*g_value + 0.0722*b_value; %weighted sum formula (Luma) to determine pg
            greyscale_image(i,j) = round(grey_pixel);
        end
    end

    greyscale_image = uint8(greyscale_image);
end