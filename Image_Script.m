%% ImageSearch.m
% ImageSearch.m perform an image search to find images contained within a
% directory that are similar to a specified image.
%
% To use this script place it into the same directory as your project code
% that you have written. You will then be able to run it from that
% directory.
%
% Note: This script calls many of your Image Fingerprint project functions,
% so you must have working versions to use this script.
%
% For convenience you may like to add the directory containing your code
% to the Matlab path, which will allow your code to be run from other
% directories as well. This can be done by setting the current folder to
% the one that contains your project files, then you can right click on the
% directory containing your code and choose:
% add to path > selected folders
%
% If you added your code directory to the path it can be convenient
% to change into the directory containing the images you want to search
% through and then run this script from that directory by typing
% ImageSearch (this will save you having to specify the directory to
% search as you can then hit enter to use the current directory).
%
% Author: Peter Bier
clc
clear
hash_alg = 'DiffHash';
resize_alg = 'Box';
% Pre-processing stage (may take some time but only needs to be done once).
% If searching the same directory frequently you would separate this stage
% out into a separate script, so that it could be run independently.
% Calculate fingerprints for all images contained within a directory
dirName = input("Enter the directory name to search through " + ...
"(hit enter to use current directory):", "s");
if isempty(dirName)
dirName = '.'; % default to current directory
end
listing = dir(dirName);
count = 0;
fnames = "";
% Iterate through the directory listing, reading in any jpg or png images.
for i = 1:length(listing)
fname = listing(i).name;
fnameLength = length(fname);
% Check if image file by seeing if it has a .jpg or .png extension.
if fnameLength > 4 && (strcmp(fname(end-3:end), ".jpg") ...
|| (strcmp(fname(end-3:end), ".png")))
count = count + 1;
fnames(count)= dirName + "/" + fname;
end
end
fprintf(1, "Read in %i files.\n", count);
fnames = fnames';
% Creating our image fingerprint collection of the directory image files.
fp_collection = FingerprintCollection(fnames, hash_alg, resize_alg);
% Obtain search image and how many to rank.
imageName = input("Enter the filename for the search image " + ...
"(e.g. dog.jpg):", "s");
n = input("Enter an integer number of similar images to display: ");
img = imread(dirName + "/" + imageName);
search_fp = ImageFingerprint(img, hash_alg, resize_alg);
assert((n <= count), "Error, cannot rank " + n + ...
" images since there are only " + count + ...
" images in the directory.")
assert((n < 100), "Error, cannot rank more than 100 similar images.")
% Find the top n most similar images and list them.
fprintf("Top %i matches for %s are:", n, imageName);
RankSimilarity(search_fp, fnames, fp_collection, n);