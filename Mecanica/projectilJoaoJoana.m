% Sebenta, Mecânica, problemas resolvidos
% Faro, qua 21 jan 2026 20:45:21 
% Written by Tordar

clear all, close all
warning('off')
x1 = 27.85;
y1 = 11.14;
v0 = 20.42;
g  =  9.8;
theta = 50;
t1 = 2.12;

np = 201; 

t = linspace(0,t1,np); 

y = -1/2*g*t.^2 + v0*sind( theta )*t;
x = v0*cosd( theta )*t;

figure( 1 ) 
plot(x,y) 
grid on, axis('equal')

coordinates = [x' y']; 

save projectilJoaoJoana.dat coordinates -ascii 

disp('done.') 
