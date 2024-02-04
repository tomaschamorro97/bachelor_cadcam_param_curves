function  [H]= catmull_weights( u0, du, uf, stage_size)
% INPUT:
%
% u0: initial parameter real value.
% du: increment in parameter value
% uf: final parameter real value ( u0 <= uf )
% stage_size: (4) Number of control points.
%
% OUTPUT:
% H(i,j): The cell (i,j) of H is Bj-1(u0+(i-1)*du), where
% Bj( ) is the j-th interpolation coefficient,
% (i=1,2,... and j=1,2,....).
%
% H is the history of curve coefficients for CATMULL curves,
% with the parameter "u" varying in the interval [u0,uf] in steps
% of size "du". The rows of H are determined by how many levels of
% the parameter "u" are there within [u0,uf] and the columns are
% termined by the number of coefficients needed for the interpolation.
% Your definition must satisfy the (a) Boundary and
% (b) Symmetry Conditions.

global CATMULL
H=[];
if (stage_size == 4)
        M = calc_M(CATMULL,stage_size);
        u = (u0:du:uf)';
        U = [];
        for expo = stage_size-1:-1:0 
            U = [U u.^expo];
        end
        H = U*M;     
else
        'error spline_weights(): wrong stage size'
        keyboad
end

end

