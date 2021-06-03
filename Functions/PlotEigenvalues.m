individual = 1;
n = numel([dir('Images\*.jpg'); dir('Images\*.gif'); dir('Images\*.png')]);
for i = 1:n
    %%  Choose Image and Calculate SVD
    [I,name] = ChooseImageGS(i);
    X = SquareMatrix(I);
    X = double(X);
    if individual == 1
        figure
        subplot(1,2,1)
        imagesc(X)
        axis off;colormap(1 - gray());
    end
    if ~exist('Data', 'dir')
       mkdir('Data')
    end
    if isfile(strcat('Data\', name, '.mat'))
        load(strcat('Data\', name, '.mat'))
    else 
        [~,S,~] = svd(X);
        save(strcat('Data\', name), 'S')
    end
    
    %% Singular Values
    ss = size(diag(S));
    s = mat2gray(diag(S));
    r = 0:1/ss(1):1-1/ss(1);
    in = randi([1 size(r,2)],1);
    if individual == 1
       subplot(1,2,2) 
    end
    loglog(r, s, 'k','LineWidth',1, 'color', ChooseColor(name)), grid on    
    xlabel('r')
    text(r(in),s(in),strcat('\leftarrow ', name))
    ylabel('Singular value, \sigma_r')
    set(gca, 'FontSize', 14)
    if individual ~= 1
        hold on
    end
    
    %subplot(1,2,2)
    %plot(cumsum(diag(S))/sum(diag(S)),'k','LineWidth',2),grid on
    %xlabel('r')
    %ylabel('Cumulative Energy')
    %set(gca, 'FontSize', 14)
    
    drawnow()
end