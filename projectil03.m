%Generating trajectory values for problem no.85
%Gambelas, 27/10/2004, 12:30
%Written by Tordar

clear all, close all

counter = 0;

theta = 60; thetarad = pi*theta/180; 
v0    = 60;
g     = 9.8;

np = 101; 

t = linspace(0,10.6,np); 

y = -1/2*g*t.^2 + v0*sin( thetarad )*t; yaux = y;
x = v0*cos( thetarad )*t;

[dummy index1] = min( abs( yaux - 100 ) ); t2a = t( index1 ); yaux( index1 ) = NaN; 
[dummy index2] = min( abs( yaux - 100 ) ); t2b = t( index2 );

vx = v0*cos( thetarad );
vya = -g*t2a + v0*sin( thetarad );
vyb = -g*t2b + v0*sin( thetarad );

cx = x(index1);
cy = y(index1); 
[cx cy],[cx+vx cy+vya]
[x1,y1] = arrow([cx cy],[cx+vx cy+vya]);

cx = x(index2);
cy = y(index2); 
[cx cy],[cx+vx cy+vyb]
[x2,y2] = arrow([cx cy],[cx+vx cy+vyb]);

counter = counter + 1 ; figure( counter ) 
plot(x,y), hold on
fill(x1,y1,'b')
fill(x2,y2,'b')
box on, grid on, axis('equal')
hold off 

M = [x' y']; 

save projectil01.dat M -ascii 
