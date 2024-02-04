function [H,U] = own_weights_quartic(u0, du, uf, stage_size )
% Prof. oscar Ruiz Salguero
% 19-04-2020
% INPUT: 
% u0: initial parameter real value.
% du: increment in parameter value
% uf: final parameter real value ( u0 <= uf )
% stage_size: (3 or 4) Number of points of the Control Polygon.
%
% OUTPUT:
% H(i,j): The cell (i,j) of H is Bj-1(u0+(i-1)*du), where
% Bj( ) is the j-th interpolation coefficient,
% (i=1,2,... and j=1,2,....).
%
% n = stage_size-1 (stage_size=3,4)
% P=[p0, p1,..., pn ]
% C(u) = B0(u)*p0 + B1(u)*p1 + ... + Bn(u)*pn
% 
% Chosen Form of Bi(u):
%            B0(u) = a0 + a1*u + a2*u^ + a3*u^3, with conditions:
%
% Boundary: 
% C(0) = p0,  C(1)=pn
% 
%
% Convexity: C(u) in Convex_Hull( P ) for all u in [0,1]:
% B0(u) + B1(u) + ... + Bn(u) = 1.0 and 
% 0.0 <= B0(u), B1(u), ... <= 1.0 and 
% 0.0 <= Bi(u) <= 1.0 for all u in [0,1].
% 
% Symmetry: B0(1-u)=B3(u) and B1(1-u)=B2(u) (or
% B0(u)=B3(1-u) and B1(u)=B2(1-u)) for all u in [u0,uf].
%
% H is the history of curve coefficients for my own curve,
% with the parameter "u" varying in the interval [u0,uf] in steps
% of size "du". The rows of H are determined by how many levels of
% the parameter "u" are there within [u0,uf] and the columns are
% termined by the number of coefficients needed for the interpolation.
% Your definition must satisfy the (a) Boundary, (b) Convexity, and
% (c) Symmetry Conditions.

H=[];
U = [];
    for u=u0:du:uf
        b0 = (1-u)^4;

        switch stage_size
        case 3
            b2 = u^4 ;
            b1 = 1 - b0 - b2 ;
            H = [H ; [b0 b1 b2]];
        case 4
            b3 = u^4 ;
            b1b2 = 1 - b0 - b3 ;
            b1 = (1-u)*b1b2 ;
            b2 =   (u)*b1b2 ;    
            H = [H ; [b0 b1 b2 b3]];    
        otherwise
            disp('error own_weights_quartic(): unexpected stage size unexpected')
            keyboard
        end
        U = [U u];
    end   

end

