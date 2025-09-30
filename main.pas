program main; 
uses crt, get_key;

const
    MATRIX_WIDTH = 36;
    MATRIX_HEIGHT = 34;
    MATRIX_BORDER_LEFT = 2;
    MATRIX_BORDER_TOP = 3;
    FIGURE_COUNT = 3;
    FIGURE_BG = '#';

type
    gameMatrixT = array [1..MATRIX_WIDTH + MATRIX_BORDER_LEFT,
        1..MATRIX_HEIGHT + MATRIX_BORDER_TOP] of char;

    gameSettings = record
        matrix: gameMatrixT;
        moveStatus: boolean;
    end;

    figureTypeNumberT = 1..FIGURE_COUNT;
    figureSizeT = record
        width, height: integer;
    end;
    figureT = record
        ftype: figureTypeNumberT;
        size: figureSizeT;
    end;


begin
end.
