function M=calc_M(stage_type,stage_size)
% Oscar Ruiz. May 12, 2008
% INPUTS:
%  stage_type: ('S'|'s'|'B'|'b'|'C'|'c'|)
%             the type of the curve: Spline, Bezier,  Catmull          
%             
%  stage_size: A natural number, which is the number of points per
%               stage.
%  OUTPUTS:
%	M:		coefficient matrix, such that Bk(u) = Uk(u) * M, where 
%			Uk=[ uk-1 uk-2...u 1 ] and Bk(u) = [ B0(u) B1(u) ... Bk-1(u) ] 
%			are the weights for the prescribed curve type (k=stage_size).

switch (stage_type)
    case {'b','B'}
        M = zeros(stage_size,stage_size);
        n = stage_size - 1;
        a=1;
      for n = n:-1:0
        for i = 0:1:n
            M(a,i+1) = factorial(n)/(factorial(i)*factorial(n-i));            
        end
        a = a + 1;
      end
      n = stage_size - 1;
      a = 1;
      for i = 0:1:n
            M(a,:) = factorial(n)/(factorial(i)*factorial(n-i)) * M(a,:);
            a = a + 1;
      end
      a=2;
      b=3;
      while n>1
          for i = 1:2:a
          M(n,i)= -1 * M(n,i);   
          end
          a = a + 2;          
          
          for j = 2:2:b
          M(n-1,j)= -1 * M(n-1,j);         
          end
          b = b + 2;
          n = n-2;
          
      end
      
      if n == 1
          for i=1:2:stage_size
              M(1,i)= -1 * M(1,i);
          end
      end
      
    case {'s','S'}
           if (stage_size==2)
              M=[[-1 1]
                 [1 0]];
           elseif (stage_size==3)
              M=(1/2)*[[1 -2 1]
                       [-2 2 0]
                       [1 1 0]];   
           elseif (stage_size==4)
              M=(1/6)*[[-1 3 -3 1]
                       [3 -6 3 0]
                       [-3 0 3 0]
                       [1 4 1 0]];
           else
              error('Error: stage_size for SPLINE must be 2,3 or 4')
           end
    case {'c','C'}
           if (stage_size==4)
              t=0.5;
              M=[   [(-t)    (2-t)   (t-2)   (t)     ]  
                    [(2*t)   (t-3)   (3-2*t) (-t)    ]
                    [ (-t)      0       t       0    ]
                    [ 0         1       0       0    ]
                ];
           else
              error('Error: stage_size for CATMULL must be 4')
           end
    otherwise
        error('Error: Wrong type of Interpolation')
end
