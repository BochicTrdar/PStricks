%Generating trajectory values for problem no.85
%Gambelas, 27/10/2004, 12:30
%Written by Tordar

clear all, close all

counter = 0;

x1 = 3600;
y1 =  600;
v0 =  240;
g  =  9.8;
a  = g*x1^2/( 2*v0^2 );
b  =  -x1;
c  =   y1 + a; 
tangens1 = ( - b + sqrt( b^2 - 4*a*c ) )/( 2*a );
tangens2 = ( - b - sqrt( b^2 - 4*a*c ) )/( 2*a );
theta1rad = atan( tangens1 ); theta1 = 180*theta1rad/pi
theta2rad = atan( tangens2 ); theta2 = 180*theta2rad/pi

np = 201; 

t = linspace(0,50,np); 

yp1 = -1/2*g*t.^2 + v0*sin( theta1rad )*t;
xp1 = v0*cos( theta1rad )*t;

yp2 = -1/2*g*t.^2 + v0*sin( theta2rad )*t;
xp2 = v0*cos( theta2rad )*t;

[dummy index1] = min( abs( xp1 - x1 ) ); xp1 = xp1(1:index1); yp1 = yp1(1:index1); 
[dummy index2] = min( abs( xp2 - x1 ) ); xp2 = xp2(1:index2); yp2 = yp2(1:index2); 

counter = counter + 1 ; figure( counter ) 
plot(xp1,yp1,xp2,yp2), grid on, axis('equal')

M1 = [xp1' yp1']; 
M2 = [xp2' yp2']; 

save projectil02a.dat M1 -ascii 
save projectil02b.dat M2 -ascii 
