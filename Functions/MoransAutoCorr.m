function MoransAutoCorr(n, ws)
    if ~exist('n','var')
        I=mat2gray(ChooseImageGS());
        ws = input('Window size: ');
    else
        I=mat2gray(ChooseImageGS(n));
    end
    A=moransI(I,ones(ws,ws)./(ws*ws),'true');
    

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
    title("Moran's I")
    colorbar
end