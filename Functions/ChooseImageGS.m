function [I,name] = ChooseImageGS(i)
    S = dir('Images');
    A = {S(~[S.isdir]).name};
    temp = num2cell(A);
    if ~exist('i','var')
        choise = menu('Choose an image', temp{:});
    else
        choise = i;
    end
    char(A(choise))
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
    I = im2double(I);
    [~,name,~] = fileparts(R);
end