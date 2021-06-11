[I,name] = ChooseImageGS();
X = SquareMatrix(I);
X = double(X);
figure
subplot(2,3,2)
imagesc(X)
axis off;colormap(1 - gray());
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
subplot(2,2,3)
s = diag(S);
loglog(s, 'k','LineWidth',1, 'color', ChooseColor(name)), grid on    
xlabel('r')
ylabel('Singular value, \sigma_r')
set(gca, 'FontSize', 14)

subplot(2,2,4)
plot(cumsum(diag(S))/sum(diag(S)),'k','LineWidth',2),grid on
xlabel('r')
ylabel('Cumulative Energy')
set(gca, 'FontSize', 14)