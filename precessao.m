% PRECESSÃO:
% Solving differential equations to determine 
% planetary motion according to Kepler's laws
% 
% Faro, 29/04/2004 at 19:30
% Written by Tordar

% PDFdoc/2004/Sebenta/Gravitacao

clear all, close all

counter = 1; 

np =  501;
M     = 1;
m     = 1;
gamma = 1;

deltat = 1;
r0 = [10 0  ];
v0 = [0 -0.1];

E(1) = m*norm( v0 )^2/2 - gamma*m*M/norm( r0 );

if E(1) > 0
disp('Total energy is positive, planet trajectory will be a hyperbola!')
elseif E(1) < 0
disp('Total energy is negative, planet trajectory will be an ellipse!')
else
disp('Total energy is zero, planet trajectory will be a parabola!')
end 

x(1) = r0(1);
y(1) = r0(2);

vx(1) = v0(1); 
vy(1) = v0(2);

t(1) = 0; 

for i = 2:np

    r = sqrt( x(i-1)^2 + y(i-1)^2 );
    r3 = r^3;
    Fx = -gamma*M*m*x(i-1)/r3;
    Fy = -gamma*M*m*y(i-1)/r3;
    ax = Fx/m;
    ay = Fy/m;
    t(i) = t(i-1) + deltat;
    vx(i) = ax*deltat/2 + vx(i-1);
    vy(i) = ay*deltat/2 + vy(i-1);
    x(i)  = x(i-1) + vx(i)*deltat;
    y(i)  = y(i-1) + vy(i)*deltat;
    theta(i) = atan2( y(i), x(i) ) ;
    r(i)     = sqrt( x(i)^2 + y(i)^2 ); 
    E(i)  = m*norm([vx(i) vy(i)])^2/2 - gamma*m*M/norm( [x(i) y(i)] );   

end

vr = [x( :) y( :)];
vv = [vx(:) vy(:)];

%counter = counter + 1; figure( counter )
%plot(x,y)
%box on, grid on, 
%axis('equal')

t2 = linspace( min( t ), max( t ), 72 ); 

[xSol,ySol] = circle(0.8,[0 0],51);

counter = counter + 1;
for i = 1:72

    [d j] = min( abs( t - t2(i) ) );
   [xMercurio,yMercurio] = circle(0.6,[x(j) y(j)],51);
    figure(counter)
    plot(x(1:j),y(1:j),'k--')
    hold on
    fill(xSol,ySol,'y',xMercurio,yMercurio,[0.7 0.7 0.7])
    text(0,0,'Sol','HorizontalAlignment','center')
    text(x(j),y(j),'Mercúrio','HorizontalAlignment','center','FontSize',6)
    axis('equal'), axis([-2 11 -4 6])
    axis('off')
    hold off 
%    print -depsc dummy.eps
    
%    !./setbox2.sh
%    !epstopdf dummy.eps
%    eval(['!mv dummy.pdf precessaoii' num2str(i-1) '.pdf'])

end

%!rm dummy.eps
