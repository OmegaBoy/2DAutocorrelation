function [color] = ChooseColor(filename)
    switch filename(1:1)
        case 'C'
            color = 'b';
        case 'N'
            color = 'y';
        case 'F'
            color = 'g';
        case 'T'
            color = 'm';
    end
end