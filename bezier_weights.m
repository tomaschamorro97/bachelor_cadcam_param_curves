function [ H ]= bezier_weights( u0, du, uf, stage_size)
% INPUT:
% u0: initial parameter real value.
% du: increment in parameter value
% uf: final parameter real value ( u0 <= uf )
% stage_size: (2,3,...) Number of control points.
%
% OUTPUT:
% H(i,j): The cell (i,j) of H is Bj-1(u0+(i-1)*du), where
% Bj( ) is the j-th interpolation coefficient,
% (i=1,2,... and j=1,2,....).
%
% H is the history of curve coefficients for BEZIER curves,
% with the parameter "u" varying in the interval [u0,uf] in steps
% of size "du". The rows of H are determined by how many levels of
% the parameter "u" are there within [u0,uf] and the columns are
% termined by the number of coefficients needed for the interpolation.
% Your definition must satisfy the (a) Boundary, (b) Convexity, and
% (c) Symmetry Conditions.

n = (stage_size-1);

N_levels_u= floor(1/du)+1;
H = zeros( N_levels_u , stage_size);
for j=0:n   
    K_jn = nchoosek(n,j);
    i=1;
    for u=u0:du:uf
        b_ij = K_jn *(1-u)^(n-j) * u^j;
        H(i,(j+1)) = b_ij;
        i  = i + 1;
    end
end

end

