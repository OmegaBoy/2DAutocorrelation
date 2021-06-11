pick = 1;
n = numel([dir('Images\*.jpg'); dir('Images\*.gif'); dir('Images\*.png')]);
for i = 1:n
    [~, name] = ChooseImageGS(i);
    S = EigAnalysis(i, 1, false);
    %% Singular Values
    ds = sort(diag(abs(S)),'descend');
    ds = ds(1:size(ds)/pick);
    ss = size(ds);
    s = mat2gray(ds);
    r = 0:1/ss(1):1-1/ss(1);
    in = randi([1 size(r,2)],1);
    loglog(r, s, 'k','LineWidth',1, 'color', ChooseColor(name)), grid on    
    xlabel('r')
    text(r(in),s(in),strcat('\leftarrow ', name))
    ylabel('Singular value, \sigma_r')
    set(gca, 'FontSize', 14)
    hold on
   
    drawnow()
end