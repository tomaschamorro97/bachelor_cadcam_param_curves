function [H]=gen_coef_history( curve_type, stage_size, u0, uf, du )
% Prof. Oscar Ruiz Salguero. 31-10-2015
% INPUT:
% curve_type: (SPLINE | BEZIER | OWN | CATMULL) the type of 
%             the curve: Spline, Bezier, Own, Catmull-Rom.
% stage_size: Number of points per stage.
%             if SPLINE-> stage_size = 2, 3, 4
%             if BEZIER-> stage_size >= 2
%             if CATMULL-> stage_size = 4
%             if OWN -> stage_size = 3, 4
% u0:         initial parameter real value.
% uf:         final parameter real value ( u0 <= uf )
% du:         increment in parameter value
%
% OUTPUT:
% H(i,j):  Cell (i,j) of H contains Bj-1(u0+(i-1)*du), 
%          where Bj( ) is the j-th interpolation 
%          coefficient  (i=1,2,... and j=1,2,....). 
%          H is the history of curve coefficients for one
%          the given cases, with the parameter "u" varying 
%          in the interval [u0,uf] in steps of size "du".
%          The rows of Mb are determined by how many 
%          levels of the parameter "u" are there within 
%          [u0,uf] and the columns are termined by the 
%          number of coefficients needed for the 
%          interpolation.

global CATMULL
global SPLINE
global BEZIER
global OWN

H=[];
switch ( curve_type )
    case {OWN}  
        if ((stage_size ==3)|(stage_size == 4))
            [H]= own_weights_quartic( u0, du, uf, stage_size );     
        else
            disp('error gen_coef_history(): wrong stage size for OWN curve'); keyboard
        end    
    case {BEZIER} 
        if (stage_size >=2 )
            [H]= bezier_weights( u0, du, uf, stage_size ); 
        else
            disp('error gen_coef_history(): wrong stage size for BEZIER curve'); keyboard            
        end            
    case {SPLINE} 
        if (stage_size==2)|(stage_size==3)|(stage_size==4)
            [H]= spline_weights( u0, du, uf, stage_size ); 
        else
            disp('error gen_coef_history(): wrong stage size for SPLINE curve'); keyboard            
        end    
    case {CATMULL}    
        if (stage_size==4)
            [H]= catmull_weights( u0, du, uf, stage_size ); 
        else
            disp('error gen_coef_history(): wrong stage size for CATMULL curve'); keyboard            
        end              
    otherwise
        disp('error gen_coef_history(): wrong curve type');  keyboard
end
end

