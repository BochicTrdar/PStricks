%***************************************************************************************
% First version: 19/04/2008
% 
% Contact: orodrig@ualg.pt
% 
% Generating an animation using pstricks. 
% 
%***************************************************************************************

nframes = 37; 

theta  = linspace(0,2*pi,nframes); 
theta2 = theta + pi/2;
theta3 = theta + pi  ;

x = 0.7*cos( theta ); 
y = 0.7*sin( theta ); 

x( abs(x) <= 2e-16 ) = 0; 
y( abs(y) <= 2e-16 ) = 0; 

xv = 0.4*cos( theta2 ); 
yv = 0.4*sin( theta2 ); 

xa = 0.4*cos( theta3 ); 
ya = 0.4*sin( theta3 ); 

xV = xv + x;
yV = yv + y;

xA = xa + x;
yA = ya + y;

xA( abs(xA) <= 2e-16 ) = 0; 
yA( abs(yA) <= 2e-16 ) = 0; 

for i = 1:nframes 

fid = fopen('frame.tex','w');

circle_coords = [ 'slopesteps=25](' num2str(x(i)) ',' num2str(y(i)) '){0.05}' ];

the_arrowV = [ '\psline[linewidth=4pt,linecolor=red]{->}('  num2str(x( i)) ',' num2str(y( i)) ')' ...
                                                       '('  num2str(xV(i)) ',' num2str(yV(i)) ')'];
						       
the_arrowA = [ '\psline[linewidth=4pt,linecolor=gray]{->}(' num2str(x( i)) ',' num2str(y( i)) ')' ...
                                                        '(' num2str(xA(i)) ',' num2str(yA(i)) ')'];
fprintf(fid,'%s\n','\documentclass[12pt]{article}');
fprintf(fid,'%s\n','\pagestyle{empty}');
fprintf(fid,'%s\n','\input{/home/orodrig/TeXdoc/Tools/newcmds}'); 
fprintf(fid,'%s\n','\usepackage{pst-all}');
fprintf(fid,'%s\n','\usepackage{pst-slpe}');
fprintf(fid,'%s\n','\begin{document}'); 
fprintf(fid,'%s\n','\null\vskip4cm');
fprintf(fid,'%s\n','\bec'); 
fprintf(fid,'%s\n','\begin{pspicture}(-1.1,0)(1.1,1.1)');
fprintf(fid,'%s\n','\psset{unit=8cm}');
fprintf(fid,'%s\n','\pscircle[linewidth=3pt,linecolor=black,linestyle=dashed,dash=5mm 1mm](0,0){0.7}');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{->}(-1,0)(1,0)');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{->}(0,-1)(0,1)');
fprintf(fid,'%s\n','\rput{0}(1.01,0){\LARGE$X$}');
fprintf(fid,'%s\n','\rput{0}(-0.05,0.95){\LARGE$Y$}');
fprintf(fid,'%s\n','\pscircle[linewidth=0.1mm,');
fprintf(fid,'%s\n','linecolor=gray,');
fprintf(fid,'%s\n','fillstyle=ccslope,');
fprintf(fid,'%s\n','slopebegin=lightgray,');
fprintf(fid,'%s\n','slopeend=black,');
fprintf(fid,'%s\n','slopecenter=0.65 0.65,');
fprintf(fid,'%s\n',circle_coords);
fprintf(fid,'%s\n',the_arrowA);
fprintf(fid,'%s\n',the_arrowV);
fprintf(fid,'%s\n','\end{pspicture}');
fprintf(fid,'%s\n','\eec');
fprintf(fid,'%s\n','\end{document}'); 

fclose( fid );

! latex2ps frame
! ps2pdf frame.ps
! pdfcrop.pl frame.pdf
! mv frame-crop.pdf frame.pdf
! mogrify -format gif frame.pdf

       if i < 11
       eval(['!mv frame.gif frame0' num2str(i-1) '.gif'])
       else
       eval(['!mv frame.gif frame'  num2str( i ) '.gif'])
       end 
       
end 

! convert -delay 15 -loop 0 frame*.gif movimento_circularV.gif
! animate movimento_circularV.gif
! rm frame*.gif *.aux *.log *.dvi *.ps frame.pdf frame.tex
