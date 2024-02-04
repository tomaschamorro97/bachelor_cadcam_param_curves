function [new_low,new_high]=update_markers( low, high, curve_type, stage_size )
% INPUT:
% low: lower index of the control polygon within an array
% high: upper index of the control polygon within an array
% curve_type: ('S'|'s'|'B'|'b'|'O'|'o'|'C'|'c')
% the type of the curve: Spline, Bezier, Own, Catmull-Rom.
% if SPLINE-> stage_size = 2, 3, or 4
% if BEZIER-> stage_size >= 2
% if CATMULL-> stage_size = 4
% if OWN -> stage_size = 3 or 4
% OUTPUT:
% new_low,
% new_high: lower and upper index, respectively, of the control polygon
% for the next iteration, according to the curve type and stage
% size specified.

global OWN BEZIER SPLINE CATMULL

switch curve_type
    case OWN
        if stage_size == 3 || stage_size == 4
            new_low = high;
            new_high = high + stage_size-1;
        else
            disp('ERROR: Wrong stage size for Own curve')
        end
    case BEZIER
        if stage_size >= 2
            new_low = high;
            new_high = high + stage_size-1;
        else
            disp('ERROR: Wrong stage size for Bezier curve')
        end
        
    case SPLINE
        if stage_size==2 || stage_size==3 || stage_size==4
            new_low = low + 1;
            new_high = high + 1;
        else
            disp('ERROR: Wrong stage size for Spline curve')
        end
    case CATMULL
        if stage_size==4
            new_low = low + 1;
            new_high = high + 1;
        else
            disp('ERROR: Wrong stage size for catmull curve')
        end
            



end
