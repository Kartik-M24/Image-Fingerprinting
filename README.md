Image Printing:

**Purpose:**
Can be used to determine whether to images are the same/similar - this can be used for identifying copyright issues or finding the original image if you only have the thumbnail.

**Description:**
The way it works is it takes in an image(s) and strips it of its colour data converting it into a GreyScale image. The size of the image is then further reduced either via ResizeBox or ResizeNearest algorithm 
to convert it into a specified size axb. It is then processed via the AvgHash or DiffHash algorithm to convert it into a 64 bit binary row vector. The image's fingerprint can than be efficiently compared to other 
images visually via the DispFP function, or automatically using the HammingDistance function which outputs the number of different bits. The RankSimilarity method outputs the results in order of most to least 
similar.

**Note the script is written by Peter Bier**
