function [S] = SVDAnalysis(i, T)
    if ~exist('i','var')
        [I,name] = ChooseImageGS();
    else
        [I,name] = ChooseImageGS(i);
    end
    if ~exist('T','var')
        T = input('¿Que porcentaje de los autovalores tomar? (Expresar de 0 a 1)\n');
    end
    %% SVD
    X = SquareMatrix(I);
    X = double(X);
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2,2,1)
    imshow(X)
    axis off;colormap(gray());
    if ~exist('Data', 'dir')
       mkdir('Data');
    end
    if isfile(strcat('Data\', name, 'U', '.mat'))
        load(strcat('Data\', name, 'U', '.mat'), 'U');
        load(strcat('Data\', name, 'S', '.mat'), 'S');
        load(strcat('Data\', name, 'V', '.mat'), 'V');
    else 
        [U,S,V] = svd(X);
        save(strcat('Data\', name, 'U'), 'U');
        save(strcat('Data\', name, 'S'), 'S');
        save(strcat('Data\', name, 'V'), 'V');
    end
    title(strcat('Imágen original (', num2str(size(S,1)), ' autovalores)'));
    %% Reconstruction
    if T < 1
        f = floor(T.*size(S,1));
    else
        f = T;
    end
    o = ones(f,1);
    z = zeros(size(S,1)-f,1);
    s = diag(S);
    dS = diag(S).*[o;z];
    cs = cumsum(diag(S))/sum(diag(S));
    dCS1 = cs(1:f);
    subplot(2,2,2)
    A = U*diag(dS)*V';
    imshow(A);
    title(strcat('Imágen reconstruida (', num2str(f), ' autovalores)'))
    %% Singular Values
    subplot(2,2,3)
    loglog(s,'k','linestyle','none', 'Marker', 'x'), grid on    
    hold on
    loglog(dS,'k','linestyle','none', 'Marker', 'x', 'color', 'r'), grid on    
    hold off
    title(strcat(num2str(size(o,1)*100/size(s,1), '%3.1f'), '% de autovalores usados'))
    ylabel('Valor Singular')
    set(gca, 'FontSize', 14)
    %% Cumulative energy
    subplot(2,2,4)
    plot(cs,'k','LineWidth',2),grid on
    hold on
    plot(dCS1,'k','LineWidth',2, 'color', 'r'),grid on
    hold off
    xlabel('r')
    ylabel('Energia acumulativa')
    set(gca, 'FontSize', 14)
    title(strcat(num2str(100*sum(dS)/sum(s), '%3.1f'), '% energía utilizada'));
end