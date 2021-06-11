function [color] = ChooseColor(filename)
    switch filename(1:1)
        case 'C'
            color = 'b';
        case 'F'
            color = 'y';
        case 'N'
            color = 'g';
        case 'P'
            color = 'm';
        case 'T'
            color = 'b';
    end
end