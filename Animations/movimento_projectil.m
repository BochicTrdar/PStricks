%***************************************************************************************
% First version: 19/04/2008
% 
% Contact: orodrig@ualg.pt
%
% Movimento de um projectil:  
% Generating an animation using pstricks. 
% 
%***************************************************************************************

clear all, close all 

counter = 0; 

nframes = 201; 

%***************************************************************************************
% Test that your parabola is O.K.:
%***************************************************************************************

xmax = 1; 

x = linspace(0,xmax,nframes);

y = -4*x.^2 + 4*x; 

dydx = -8*x + 4; thetas = atan( dydx ); 

%***************************************************************************************
% Matlab animation:
%***************************************************************************************

counter = counter + 1;

%plot(x,y), box on, grid on

for i = 1:nframes

    [xarrowr,yarrowr] = arrow([x(1) y(1)],[x(i) y(i)]); 
    [xarrowv,yarrowv] = arrow([x(i) y(i)],[x(i)+0.5*cos(thetas(i)) y(i)+0.5*sin(thetas(i))]);
    [xarrowg,yarrowg] = arrow([x(i) y(i)],[x(i) y(i)-0.4]);
    
    figure(counter)
    plot(x,y),hold on
    fill(xarrowr,yarrowr,'y')
    fill(xarrowv,yarrowv,'b')
    fill(xarrowg,yarrowg,'r')
    axis([0 1.2 -0.5 1.5])
    hold off
    
end
