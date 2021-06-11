function WKAutoCorr(n)
    if ~exist('n','var')
        I=mat2gray(ChooseImageGS());
    else
        I=mat2gray(ChooseImageGS(n));
    end
    A=autocorr2d(I);
    figure;
    subplot(1,2,1)
    imshow(I)
    axis equal tight
    box on
    xlabel('X')
    ylabel('Y')
    title('Imagen Original')
    colorbar

    subplot(1,2,2)
    d_max=size(I,1)/2 +1;
    imagesc(-size(I,1)/2:size(I,1)/2-1,-size(I,1)/2:size(I,1)/2-1,A,[-1,1])
    axis equal tight
    box on
    xlabel('X')
    ylabel('Y')
    title('Autocorrelacion espacial')
    colorbar
end