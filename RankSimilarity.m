%This function takes in four inputs, search_fingerprint- a 1x64 logical
%row vector which is the image fingerprint that is used to compare all the
%other fingerprints to, filenames_list - a mx1 string array containing the
%list of filenames of the images, fingerprint_collection - a mx1 cell array
%containing the fingerprints of each image, and n - the number of image
%fingerprints comparisons to display. This function works by taking in all
%these inputs and comparing each of the image file's fingerprints to the
%searchfile's using the HammingDistance function. It then organises the
%list of images in order of least different to most different to the search
%image. Images with the same amount of difference are ordered by the order
%they're inputted in. This function has no output but displays the rankings, 
%hamming distance value and then the file name up to the nth file in that 
%order, with the appropriate formatting in the workspace using fprintf. 
%
%Author: Kartik Malik
function RankSimilarity(search_fingerprint, filenames_list, fingerprint_collection, n)

    %Predetermines/Pre-allocates values are stored below
    [rows,~] = size(filenames_list);
    hamval_array = zeros(rows,1);
    
    %Creates column vector of hamming distance values
    for i = 1:rows
        file = fingerprint_collection{i};
        ham = HammingDistance(search_fingerprint, file);
        hamval_array(i,1) = ham; %array of hamming distance values associated with the filenames
    end

    %The following algorithm retrieved from Matlab Documentation https://au.mathworks.com/help/matlab/ref/sort.html#bup2pxc "[B,I] = sort(_)
    [hamval_ordered, order_num] = sort(hamval_array, 'ascend'); %orders the hamming distance values whilst keeping reference to the 
    %order number of the files in filenames_list, to break ties.
      
    %Displays rankings, hamming distance value and filename up to the nth file with the correct formatting
    for i = 1:n
        if n<10
            fprintf('%1i. %2i - %s\n', i, double(hamval_ordered(i,1)), strip(filenames_list(order_num(i,1),1))); %prints the rank without any spacing
        else
            fprintf('%2i. %2i - %s\n', i, double(hamval_ordered(i,1)), strip(filenames_list(order_num(i,1),1))); %prints any ranks 1-9 with one space before it
        end
    end

end
