function [newMatrix] = SquareMatrix(matrix)
%SQUAREMATRIX Summary of this function goes here
%   Detailed explanation goes here
sm = size(matrix);
midx = floor(sm(1)/2);
midy = floor(sm(2)/2);
if sm(2) > sm(1)
    sqsize = sm(1);
else
    sqsize = sm(2);
end
mid = floor(sqsize/2);
newMatrix = matrix(midx - mid + 1:midx - mid + sqsize,midy - mid + 1:midy - mid + sqsize);
end

