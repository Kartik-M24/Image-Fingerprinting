%This function takes in the inputs colour_image - an mxnx3 uint8 colour
%image, hash_type - a character vector either 'AvgHash' or 'DiffHash' which
%allows the program to know what hashing function to apply to the image,
%and algorithm_type - a character vector either 'Nearest' or 'Box' which
%lets the program know how the user wants the image resized. This function
%works by first calling the GreyscaleLuma function to convert the colour
%image into a greyscale image, before using the inputs to apply the
%appropriate resizing and hash to the image. Once these steps are complete
%the output is assigned to img_fingerprint - 1x64 logical row vector
%containing the image's fingerprint.
%
%Author: Kartik Malik
function [img_fingerprint] = ImageFingerprint(colour_image, hash_type, algorithm_type)

    %Determines if the input matches the character vector returning either logical 1 or 0
    type1 = strcmpi(algorithm_type, 'Nearest'); %checks for input value to determine how the image should be resized
    type2 =  strcmpi(hash_type, 'AvgHash'); %checks for input value to deermine how the pixels should be compared

    img = GreyscaleLuma(colour_image); %converts colour image into a greyscale image
    
    if type1 == 1
        if type2 == 1 %if inputs are 'Nearest' and 'AvgHash'
            img = ResizeNearest(img, [8,8]);
            img_fingerprint = AvgHash(img);
        else% if inputs are 'Nearest' and 'DiffHash'
            img = ResizeNearest(img, [8,9]);
            img_fingerprint = DiffHash(img);
        end
    
    else
        if type2 == 1 %if inputs are 'Box' and 'AvgHash'
            img = ResizeBox(img, [8,8]);
            img_fingerprint = AvgHash(img);
        else %if inputs are 'Box' and 'DiffHash'
            img = ResizeBox(img, [8,9]);
            img_fingerprint = DiffHash(img);
        end
    end

end