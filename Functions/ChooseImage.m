function [I, ColorType, BitDepth] = ChooseImage(i)
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
    ColorType = ii.ColorType;
    BitDepth = ii.BitDepth;
    switch ii.ColorType
        case 'truecolor'
            I = imread(R);
        case 'indexed'
            I = imread(R);
        case 'grayscale'
            I = imread(R);
    end
end