%content_addressable_memory.m:
% read in files to memorize and cues to recover memories
%note: put bitmaps in same directory as this file

A = imread('happyworld.bmp'); % example file to read in.

[nrows, ncols] = size(A); %get bitmap dimensions;
% need to remember these to convert vector back to matrix
nbits = nrows * ncols; %when string out matrix, will have this many bits in vector

Avec = matrix2vec(A); %convert image to a bipolar vector

%create matrix memory from this vector
% EXPLORE ALTERNATIVES: suppress diagonal terms?
MatrixMem = Avec * Avec'; %outer product

% read in some more images...
    % experiment with how many and which images to read in...
A = imread('clubspade.bmp');
Avec = matrix2vec(A);
M = Avec * Avec'; % again, consider partial or full suppression of diagonal
MatrixMem = MatrixMem + M; %include more memories by merely adding them into matrix

%ditto for more bitmaps...
A = imread('printtrash.bmp')
Avec = matrix2vec(A);
M = Avec * Avec'; % again, consider partial or full suppression of diagonal
MatrixMem = MatrixMem + M; %include more memories by merely adding them into matrix

A = imread('handheart.bmp')
Avec = matrix2vec(A);
M = Avec * Avec'; % again, consider partial or full suppression of diagonal
MatrixMem = MatrixMem + M; %include more memories by merely adding them into matrix

A = imread('computersum.bmp')
Avec = matrix2vec(A);
M = Avec * Avec'; % again, consider partial or full suppression of diagonal
MatrixMem = MatrixMem + M; %include more memories by merely adding them into matrix

A = imread('winhelp.bmp')
Avec = matrix2vec(A);
M = Avec * Avec'; % again, consider partial or full suppression of diagonal
MatrixMem = MatrixMem + M; %include more memories by merely adding them into matrix

A = imread('notespell.bmp')
Avec = matrix2vec(A);
M = Avec * Avec'; % again, consider partial or full suppression of diagonal
MatrixMem = MatrixMem + M; %include more memories by merely adding them into matrix

size(MatrixMem)% debug--should be 512x512 for these examples

fname = input('enter filename of cue: ', 's'); %prompt for a cue (flawed memory)
Aerr = imread(fname);

Avec_err = matrix2vec(Aerr);
AVecRecall = Avec_err;

%! Memory Supression:
[i, j] = size(MatrixMem);

for x = 1:min(i, j)
    MatrixMem(x, x) = 0;
end

while 1 > 0% infinite loop...
        nupdates = input('enter number of nodes to update:')
    numchanges = 0;

    for iupdate = 1:nupdates
        [AVecRecall, delta] = updateRandomNode(MatrixMem, AVecRecall); %WRITE THIS FUNCTION
        numchanges = numchanges + delta;
    end

    numchanges%print out how many nodes were changed
    AmatCorrected = vec2matrix(AVecRecall, nrows, ncols); %convert vector back to matrix

    imwrite(AmatCorrected, 'processedMemory.bmp')%and write matrix as a bitmap
    %may view these bitmaps to observe progress.
end %runs forever...will have to ctl-C to halt
