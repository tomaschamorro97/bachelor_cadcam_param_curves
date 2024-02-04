%Tomas Chamorro Pareja
%201610011014
%10/22/2020

clc
clear all
close all

global OWN BEZIER SPLINE CATMULL
OWN = 'o';
BEZIER = 'b';
SPLINE = 's';
CATMULL = 'c';

u0 = 0;
uf = 1;
du = 0.05;
U = u0:du:uf;
U = U';
my_palette = [[1 1 0];[1 0 1];[0 1 1];[1 0 0];[0 1 0];[0 0 1]];


[Ha]=gen_coef_history( BEZIER, 4, 0, 1.0, 0.05);
figure (1)
plot(U,Ha)
title('BEZIER curve, stage size = 7')
grid


[Hb]=gen_coef_history( SPLINE, 4, 0, 1.0, 0.05);
figure (2)
plot(U,Hb)
grid
title('SPLINE curve, stage size = 4')


[Hc]=gen_coef_history( CATMULL, 4, 0, 1.0, 0.05);
figure (3)
plot(U,Hc)
grid
title('CATMULL curve, stage size = 4')


[Hd]=gen_coef_history( OWN, 3, 0, 1.0, 0.05);
figure (4)
plot(U,Hd)
grid
title('OWN curve, stage size = 3')


[He]=gen_coef_history( OWN, 4, 0, 1.0, 0.05);
figure (5)
plot(U,He)
grid
title('OWN curve, stage size = 4')


P = load('control_polygon.txt');
figure (6)
hold on
plot3(P(1,:),P(2,:),P(3,:),'-ro')
title('Control polygon')
grid

%% 4- (title="CORD b2o01")

figure(7)
hold on
plot3(P(1,:),P(2,:),P(3,:),'-ro')
grid
title('CORD b2o01')
C1= full_curve(P, 'b', 2, 'o', du );
plot3(C1(1,:),C1(2,:),C1(3,:),'-b')

%% 5- (title="CORD s3o01")

figure(8)
hold on
plot3(P(1,:),P(2,:),P(3,:),'-ro')
grid
title('CORD s3o01')
C2= full_curve(P, 's', 3, 'o', du );
plot3(C2(1,:),C2(2,:),C2(3,:),'-b')


%% 6- (title="CORD c4c01")

figure(9)
hold on
plot3(P(1,:),P(2,:),P(3,:),'-ro')
grid
title('CORD c4c01')
C3= full_curve(P, 'c', 4, 'c', du );
plot3(C3(1,:),C3(2,:),C3(3,:),'-b')

%% 7- (title="CORD o3c01")

figure(10)
hold on
plot3(P(1,:),P(2,:),P(3,:),'-ro')
grid
title('CORD CORD o3c01')
C4= full_curve(P, 'o', 3, 'c', du );
plot3(C4(1,:),C4(2,:),C4(3,:),'-b')



%% 8- (title="CORD o4c01")

figure(11)
hold on
plot3(P(1,:),P(2,:),P(3,:),'-ro')
grid
title('CORD CORD o4c01')
C5= full_curve(P, 'o', 4, 'c', du );
plot3(C5(1,:),C5(2,:),C5(3,:),'-b')

%% 9- (title="CORD b6c005")

figure(12)
hold on
plot3(P(1,:),P(2,:),P(3,:),'-ro')
grid
title('CORD CORD b6c005')
C6= full_curve(P, 'b', 6, 'c', 0.05 );
plot3(C6(1,:),C6(2,:),C6(3,:),'-b') 
draw_my_palette(C6,(1/0.05)+1,my_palette)






