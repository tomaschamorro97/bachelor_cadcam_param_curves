  function [Compl_PX,Compl_PY,Compl_PZ]=complete_control_polyhedron(PX,PY,PZ, type_cols, pts_per_stage, closure )
% INPUT:
%    PX,PY,PZ:(_  x N_pts_cols) control polyhedron.
%    type_cols:interpolation type BEZIER|SPLINE|OWN|CATMULL
%    (Bezier, Spline, Own, Catmull-Rom).
%    pts_per_stage:points per stage.
%    closure:character ('O' | 'o' | 'C' | 'c' ) which indicates the closure
%    conditions of the parametric form.  Closure being Open or
%    Closed implies the usage of cells (:,1) or cells (:,N_pts),
%    respectively, of the control polyhedron to complete it.
%
%
% OUTPUT:
%    Compl_PX,Compl_PY,Compl_PZ:
%        the control polyhedron, completed to produce a Open or Closed
%        (as requested ) surface IN THE COLUMN DIRECTION. The parametric forms
%        should employ all given points. Therefore, The filling material must
%        be appended as needed to build or complete a last stage to achieve
%        the desired closure.
%
% NOTE: To complete PX,PY,PZ in the ROW direction,
%        this function must be called with the
%        transposed versions of PX,PY,PZ.

global BEZIER
global OWN
global SPLINE
global CATMULL

Compl_PX = PX  ;
Compl_PY = PY  ;
Compl_PZ = PZ  ;

switch(type_cols)
    case{BEZIER,OWN}
        switch(closure)   
            case{'O','o'}
                N_cols = size(PX,2);
                low_col = 1;
                up_col = pts_per_stage ;
                while ( up_col <= N_cols )
                    [low_col , up_col] = update_markers( low_col , up_col, type_cols , pts_per_stage );
                end
                if ( low_col < N_cols)
                    add_cols = up_col - N_cols;
                    Compl_PX = [PX  PX(:,N_cols) * ones(1,add_cols) ];
                    Compl_PY = [PY  PY(:,N_cols) * ones(1,add_cols) ];
                    Compl_PZ = [PZ  PZ(:,N_cols) * ones(1,add_cols) ];
                end
                
            case{'C','c'}
                N_cols = size(PX,2);
                low_col = 1;
                up_col = pts_per_stage ;
                while ( up_col <= N_cols )
                    [low_col , up_col] = update_markers( low_col , up_col, type_cols , pts_per_stage );
                end
                if ( low_col < N_cols)
                    add_cols = up_col - N_cols;
                    Compl_PX = [PX  PX(:,1) * ones(1,add_cols) ];
                    Compl_PY = [PY  PY(:,1) * ones(1,add_cols) ];
                    Compl_PZ = [PZ  PZ(:,1) * ones(1,add_cols) ];
                end
            otherwise
                'error close_control_polyhedron(): wrong closure'
                keyboard                
        end
        
        
    case{SPLINE ,CATMULL}
        switch(closure)
            case{'O','o'}
                return;
            case{'C','c'}
                Compl_PX = [PX  PX(:   ,   1:(pts_per_stage-1)) ];
                Compl_PY = [PY  PY(:   ,   1:(pts_per_stage-1)) ];
                Compl_PZ = [PZ  PZ(:   ,   1:(pts_per_stage-1)) ];
            otherwise
                'error close_control_polyhedron(): wrong closure'
                keyboard
        end
        
    otherwise
        'error close_control_polyhedron(): wrong curve type'
        keyboard
end
end