from numpy import * 
from scipy import *
from matplotlib.pyplot import *

R = 5.0
thetamax = 45
n = 1.25
ymax = R*sin( thetamax*pi/180 )
xmax = R*cos( thetamax*pi/180 )

nthetas = 101
thetas = linspace( -thetamax , thetamax, nthetas )
x = R*cos( thetas*pi/180 )
y = R*sin( thetas*pi/180 )
xii = 2*xmax - x

y0 = 0.9*ymax
xi = 2*xmax - sqrt( R*R - y0*y0 )

theta1  = arcsin( y0/R )
theta1p = arcsin( sin(theta1)/n ) # theta1p < theta1 because sin( theta1p ) < sin( theta1 )!!!!!

theta2 = theta1 - theta1p
k2 = tan( theta2 )
x2 = -y0/k2 + xi

a = 1 + k2*k2
b = -( k2*xi + y0 )*2*k2
c = k2*k2*xi*xi + 2*k2*y0*xi + y0*y0 - R*R

xipi  = ( -b + sqrt( b*b - 4*a*c ) )/( 2*a ) 
xipii = ( -b - sqrt( b*b - 4*a*c ) )/( 2*a )
xip = max([xipi,xipii])
yip = -k2*( xip - xi ) + y0

alpha1 = arctan( yip/xip )
alpha2 = arctan( (y0-yip)/(xip-xi) )
alpha  = alpha1 + alpha2
beta   = arcsin( n*sin( alpha ) )
theta3 = beta - alpha1

xf = xip + yip/tan( theta3 )

xray1 = array([0,xi ,xip,xf])
yray1 = array([y0,y0,yip, 0])

figure(1)
plot(x ,y,linewidth=2)
plot(xii,y,linewidth=2)
plot(xray1,yray1)
grid(True)
xlim(0,2*R)
ylim(-R,R)
show()
