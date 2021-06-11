function [] = PlotMean(arrays, color)
    maxlen=max(cellfun('prodofsize',arrays));
    for n=1:numel(arrays)
        current_elem=numel(arrays{n});
        if current_elem<maxlen
            arrays{n}((current_elem+1):maxlen)=NaN;
        end
    end
    extradim=1+ndims(arrays{1});
    bigarray=cat(extradim,arrays{:});
    S = mean(bigarray,extradim,'omitnan');
    ss = size(diag(S));
    r = 0:1/ss(1):1-1/ss(1);
    loglog(r, S, 'k','LineWidth',1, 'color', color), grid on
end