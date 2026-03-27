%***************************************************************************************
% First version: 19/04/2008
% 
% Contact: orodrig@ualg.pt
%
% Movimento de um projectil: vector-posição
% Generating an animation using pstricks. 
% 
%***************************************************************************************

clear all, close all 

counter = 0; 

nframes = 37; 

xmax = 1; 

x = linspace(0,xmax,nframes);

y = -4*x.^2 + 4*x; 

dydx = -8*x + 4; thetas = atan( dydx ); 

x2 = x + 0.45*cos(thetas) ; 
y2 = y + 0.45*sin(thetas) ;

for i = 1:nframes 

fid = fopen('frame.tex','w');

the_arrowV = [ '\psline[linewidth=5pt,linecolor=red]{->}(' num2str(x(i)) ',' num2str(y(i)) ')' ...
'('  num2str(x2(i)) ',' num2str(y2(i)) ')' ]; 

the_arrowA = [ '\psline[linewidth=5pt,linecolor=gray]{->}('  num2str(x(i)) ',' num2str(y(i)) ')' ...
'('  num2str(x(i)) ',' num2str(y(i)-0.3) ')' ]; 

the_circle = [ '\pscircle[fillstyle=solid,fillcolor=blue](' num2str(x(i)) ',' num2str(y(i)) '){0.02}' ];

fprintf(fid,'%s\n','\documentclass[12pt]{article}');
fprintf(fid,'%s\n','\pagestyle{empty}');
fprintf(fid,'%s\n','\input{/home/orodrig/TeXdoc/Tools/newcmds}'); 
fprintf(fid,'%s\n','\usepackage{pst-all}'); 
fprintf(fid,'%s\n','\begin{document}'); 
fprintf(fid,'%s\n','\null\vskip10cm'); 
fprintf(fid,'%s\n','\begin{pspicture}(0,-0.5)(1.65,1.3)');
fprintf(fid,'%s\n','\psset{unit=10cm}');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{->}(0,-0.5)(0,1.2)');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{->}(0,0)(1.2,0)');
fprintf(fid,'%s\n','\parabola[linewidth=2pt,linecolor=black,linestyle=dashed,dash=5mm 1mm](0,0)(0.5,1)');
fprintf(fid,'%s\n',the_circle); 
fprintf(fid,'%s\n',the_arrowV); 
fprintf(fid,'%s\n',the_arrowA); 
fprintf(fid,'%s\n','\rput{0}(1.2,0.075){\LARGE$X$}');
fprintf(fid,'%s\n','\rput{0}(0,1.25){\LARGE$Y$}');
fprintf(fid,'%s\n','\end{pspicture}');
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

! convert -delay 10 -loop 0 frame*.gif movimento_projectilV.gif
! animate movimento_projectilV.gif
! rm frame*.gif *.aux *.log *.dvi *.ps frame.pdf frame.tex
