function [I] = ChooseImageGS(i)
    S = dir('Images');
    A = {S(~[S.isdir]).name};
    temp = num2cell(A);
    if ~exist('i','var')
        choise = menu('Choose an image', temp{:});
    else
        choise = i;
    end
    R = strcat('Images\', char(A(choise)));
    ii = imfinfo(R);
    switch ii.ColorType
        case 'truecolor'
            I = rgb2gray(imread(R));
        case 'indexed'
            [X,map] = imread(R);
            I = ind2gray(X,map);
        case 'grayscale'
            I = imread(R);
    end
end