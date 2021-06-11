pick = 1;
n = numel([dir('Images\*.jpg'); dir('Images\*.gif'); dir('Images\*.png')]);
CA = {};
IA = {};
FA = {}; 
TA = {}; 
for i = 1:n
    %%  Choose Image and Calculate SVD
    [I,name] = ChooseImageGS(i);
    X = SquareMatrix(I);
    X = double(X) - mean(double(X));
    if ~exist('Data', 'dir')
       mkdir('Data')
    end
    if isfile(strcat('Data\', name, '.mat'))
        load(strcat('Data\', name, '.mat'))
    else 
        [~,S,~] = svd(X);
        save(strcat('Data\', name), 'S')
    end
end

n = numel([dir('Images\*.jpg'); dir('Images\*.gif'); dir('Images\*.png')]);
for i = 1:n
    [I,name] = ChooseImageGS(i);
    load(strcat('Data\', name, '.mat'))
    %% Singular Values
    ds = diag(S);
    ds = ds(1:size(ds)/pick);
    ss = size(ds);
    s = mat2gray(ds);
    r = 0:1/ss(1):1-1/ss(1);
    in = randi([1 size(r,2)],1);
    subplot(1,2,1) 
    loglog(r, s, 'k','LineWidth',1, 'color', ChooseColor(name)), grid on    
    xlabel('r')
    text(r(in),s(in),strcat('\leftarrow ', name))
    ylabel('Singular value, \sigma_r')
    set(gca, 'FontSize', 14)
    hold on
    
    switch name(1:1)
        case 'C'
            CA{end+1} = ds;
        case 'I'
            IA{end+1} = ds;
        case 'F'
            FA{end+1} = ds;
        case 'T'
            TA{end+1} = ds;
    end
    
    drawnow()
end

n = numel([dir('Images\*.jpg'); dir('Images\*.gif'); dir('Images\*.png')]);
for i = 1:n
    %%  Choose Image and Calculate SVD
    [I,name] = ChooseImageGS(i);
    load(strcat('Data\', name, '.mat'))
    
    ds = diag(S);
    ds = ds(1:size(ds)/pick);
    subplot(1,2,2)
    plot(cumsum(ds)/sum(ds),'k','LineWidth',1, 'color', ChooseColor(name)),grid on
    xlabel('r')
    ylabel('Cumulative Energy')
    set(gca, 'FontSize', 14)
    hold on
    
    drawnow()
end

figure;
PlotMean(CA, ChooseColor('C'));
hold on;
PlotMean(IA, ChooseColor('F'));
hold on;
PlotMean(FA, ChooseColor('N'));
hold on;
PlotMean(TA, ChooseColor('T'));
hold off;