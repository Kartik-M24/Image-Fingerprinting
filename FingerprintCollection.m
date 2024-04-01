%This function takes in three inputs, filenames_list - a mx1 string array
%containing a list of image filenames. hash_type - a character vector 
%either 'AvgHash' or 'DiffHash' which allows the program to know what 
%hashing function the user wants applied, and algorithm_type - a character 
%vector either 'Nearest' or 'Box' which lets the program know what resizing
%algorithm the user wants applied. The purpose of this function is to
%determine the fingerprint of multiple different image files simultaneously
%and store the fingerprints in a cell array as this is more efficient. The
%code does this by determining the number of files names in the list and
%preallocating a cell for the number of fingerprints that will be
%outputted. It then goes through the list of image files, reads it then
%inputs it into the ImageFingerprint function with the hash_type and
%algorithm_type specified by the user in the input of the
%FingerprintCollection. Each  outputted value from the ImageFingerprint is
%then saved into the corresponding cell array until this process has been
%done to all the files in the filenames_list. The output will be a mx1 cell
%array where each cell from 1-m will be a 1x64 logical row vector.
%
%Author: Kartik Malik
function [fingerprint_cell] = FingerprintCollection(filenames_list, hash_type, algorithm_type)
    
    %Predetermines/Pre-allocates values are stored below
    [m, ~] = size(filenames_list);
    fingerprint_cell = cell(m,1);
    
    %Goes through each file in the list of filenames, reads it then inputs it into the ImageFingerprint 
    %function with the appropriate inputs. The output of this function is then assigned according to its
    %position within the cell array.
    for i = 1:m
        file = imread(filenames_list(i));
        fingerprint_cell{i,1} = ImageFingerprint(file, hash_type, algorithm_type);
    end

end