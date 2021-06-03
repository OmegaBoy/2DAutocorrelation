function [S] = Eigenvalues(n)
    %%  Choose Image and Calculate SVD
    if ~exist('n','var')
        X=SquareMatrix(ChooseImageGS());
    else
        X=SquareMatrix(ChooseImageGS(n));
    end
    
    X = double(X);
    [~,S,~] = svd(X);

    %% Singular Values
    sx = size(X);
    overload = sx(1)*1.05 - sx(1);
    figure, subplot(1,2,1)
    semilogy(diag(S), 'k','LineWidth',2), grid on
    xlabel('r')
    ylabel('Singular value, \sigma_r')
    xlim([-overload  sx(1) + overload])
    set(gca, 'FontSize', 14)

    subplot(1,2,2)
    plot(cumsum(diag(S))/sum(diag(S)),'k','LineWidth',2),grid on
    xlabel('r')
    ylabel('Cumulative Energy')
    xlim([-overload  sx(1) + overload]); ylim([0, 1.1])
    set(gca, 'FontSize', 14)

    %% Correlation Matrices
    figure
    XXt = X*X';
    XtX = X'*X;
    subplot(1,2,1);
    imagesc(XtX);
    axis off;colormap(1 - gray());
    subplot(1,2,2);
    imagesc(XXt);
    axis off;colormap(1 - gray());    
end