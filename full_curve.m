function [C]=full_curve(P, type, stage_size, closure, d_param )
% INPUT:
% P: a control polygon (3 x __).
% type: interpolation type: 'b'|'B'|'s'|'S'|'o'|'O'|'c'|'C'
% (Bezier, Spline, Own, Catmull-Rom).
% stage_size: number of points per stage.
% stage_size: points per stage.
% if SPLINE-> stage_size = 2, 3, or 4
% if BEZIER-> stage_size >= 2
% if CATMULL-> stage_size = 4
% if OWN -> stage_size = 3 or 4
% closure: If 'C' or 'c' , the control polygon must be closed.
% Otherwise, leave it untouched.
% d_param: parameter increment.
%
% OUTPUT:
% C: the general collection of sub-curves, put togeher.
% This function completes and partitions the input control polygon
% into the small local control polygons, needed to fit the local
% curve, as per the specified inputs. Each local curve follows the
% interpolation type, with the prescribed number of
% control points. The function is able to close the curve if required.
% splines or CATMULL-ROM Splines are "closed" by appending at the end of the
% control polygon the (k-1) first control points (k=points per stage).


global OWN CATMULL BEZIER SPLINE

C = [];
u0 = 0;
uf= 1;
low = 1;
high = stage_size;
[Compl_PX,Compl_PY,Compl_PZ]=complete_control_polyhedron(P(1,:),P(2,:),P(3,:), type, stage_size, closure );
new_P = [Compl_PX;
         Compl_PY;
         Compl_PZ];

switch type
    case {OWN,BEZIER,SPLINE,CATMULL}
        while size(new_P,2)>=high
            M=gen_coef_history( type, stage_size, u0, uf, d_param );
            c = new_P(1:3,low:high)*M';
            C = [C c];
            [low,high]=update_markers( low, high, type, stage_size );
        end   
end

            
        