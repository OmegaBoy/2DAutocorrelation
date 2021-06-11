function [S] = EIGAnalysis(i, T, showPlot)
    if ~exist('i','var')
        [I,name] = ChooseImageGS();
    else
        [I,name] = ChooseImageGS(i);
    end
    if ~exist('T','var')
        T = input('¿Que porcentaje de los autovalores tomar? (Expresar de 0 a 1)\n');
    end
    if ~exist('showPlot','var')
        showPlot = true;
    end
    %% EIG
    X = SquareMatrix(I);
    X = double(X);
    if showPlot 
        figure('units','normalized','outerposition',[0 0 1 1])
    end
    if showPlot
        subplot(2,2,1)
        imshow(X)
        axis off;colormap(gray());
    end
    if ~exist('Data', 'dir')
       mkdir('Data');
    end
    if isfile(strcat('Data\', name, 'EU', '.mat'))
        load(strcat('Data\', name, 'EU', '.mat'), 'U');
        load(strcat('Data\', name, 'ES', '.mat'), 'S');
    else 
        [U,S,~] = eig(X);        
        save(strcat('Data\', name, 'EU'), 'U');
        save(strcat('Data\', name, 'ES'), 'S');
    end
    %% Reconstruction
    if T < 1
        f = floor(T.*size(S,1));
    else
        f = T;
    end
    o = ones(f,1);
    z = zeros(size(S,1)-f,1);
    s = diag(abs(S));
    dS = S.*[o;z];
    cs = cumsum(s)/sum(s);
    dCS1 = cs(1:f);
    A = U*dS/U;
    if showPlot
        title(strcat('Imágen original (', num2str(size(S,1)), ' autovalores)'));
        subplot(2,2,2)
        imshow(A);
        title(strcat('Imágen reconstruida (', num2str(f), ' autovalores)'))
        %% Singular Values
        subplot(2,2,3)
        loglog(s,'k','linestyle','none', 'Marker', 'x'), grid on    
        hold on
        loglog(abs(diag(dS)),'k','linestyle','none', 'Marker', 'x', 'color', 'r'), grid on    
        hold off
        title(strcat(num2str(size(o,1)*100/size(s,1), '%3.1f'), '% de autovalores usados'))
        ylabel('Autovalor')
        set(gca, 'FontSize', 14)
        %% Cumulative energy
        subplot(2,2,4)
        plot(abs(cs),'k','LineWidth',2),grid on
        hold on
        plot(abs(dCS1),'k','LineWidth',2, 'color', 'r'),grid on
        hold off
        xlabel('r')
        ylabel('Energia acumulativa')
        set(gca, 'FontSize', 14)
        title(strcat(num2str(100*sum(abs(diag(abs(dS))))/sum(abs(s)), '%3.1f'), '% energía utilizada'));
    end
end