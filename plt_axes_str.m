function []=plt_axes_str(cords, L, A, B, C,label_x,label_y,label_z,label_o)
% Updated: Sept 01, 2007. by Oscar Ruiz
% Authors: Oscar Ruiz and research assistat David Uribe. 
% CAD CAM CAE LAboratory at EAFIT University. February 2007.
% This function draws a coordinate system, with controlable size
% and labels.
% INPUTS
% cords:	A coordinate system (3x4, cartesian) or (4x4, homogeneous) 
%           in this order [X,Y,Z,O].
% L:        scale factor (real number) 
% A, B,C:	colors for the X,Y,Z axes, respectively.
% label_x,label_y,label_z,label_o: labels for X,Y,Z axes and Origin.

Px=cords(1:3,1)';
Py=cords(1:3,2)';
Pz=cords(1:3,3)';
S=cords(1:3,4);

cg=S;

label_x = cat(2,'  \bf\it',label_x);
label_y = cat(2,'  \bf\it',label_y);
label_z = cat(2,'  \bf\it',label_z);
label_o = cat(2,'  \bf\it',label_o);


plot3([cg(1) cg(1)+L*Px(1)],...   %Ploting X axis
      [cg(2) cg(2)+L*Px(2)],...
      [cg(3) cg(3)+L*Px(3)], A, 'LineWidth', 1.5)
  hold on
plot3([cg(1) cg(1)+L*Py(1)],...   %Ploting Y axis
      [cg(2) cg(2)+L*Py(2)],...
      [cg(3) cg(3)+L*Py(3)], B, 'LineWidth', 1.5)
  hold on
plot3([cg(1) cg(1)+L*Pz(1)],...   %Ploting Z axis
      [cg(2) cg(2)+L*Pz(2)],...
      [cg(3) cg(3)+L*Pz(3)], C, 'LineWidth', 1.5)
  hold on
%--------------------------------------------------------------------------
% Modificate Matrix Householder transformation
text(cg(1)+L*Px(1),cg(2)+L*Px(2),...
     cg(3)+L*Px(3),label_x)
text(cg(1)+L*Py(1),cg(2)+L*Py(2),...
     cg(3)+L*Py(3),label_y)
text(cg(1)+L*Pz(1),cg(2)+L*Pz(2),...
     cg(3)+L*Pz(3),label_z)
text(cg(1),cg(2),cg(3),label_o)
grid on 
axis equal
k=1;
view(130,30)
