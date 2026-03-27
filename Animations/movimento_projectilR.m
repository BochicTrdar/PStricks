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

for i = 1:nframes 

fid = fopen('frame.tex','w');

the_arrow  = [ '\psline[linewidth=5pt,linecolor=red]{->}(0,0)('  num2str(x(i)) ',' num2str(y(i)) ')']; 
the_circle = [ '\pscircle[fillstyle=solid,fillcolor=blue](' num2str(x(i)) ',' num2str(y(i)) '){0.02}' ];

fprintf(fid,'%s\n','\documentclass[12pt]{article}');
fprintf(fid,'%s\n','\pagestyle{empty}');
fprintf(fid,'%s\n','\input{/home/orodrig/TeXdoc/Tools/newcmds}'); 
fprintf(fid,'%s\n','\usepackage{pst-all}'); 
fprintf(fid,'%s\n','\begin{document}'); 
fprintf(fid,'%s\n','\null\vskip10cm');
fprintf(fid,'%s\n','\bec'); 
fprintf(fid,'%s\n','\begin{pspicture}(0,0)(1.1,1.1)');
fprintf(fid,'%s\n','\psset{unit=10cm}');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{<->}(0,1)(0,0)(1,0)');
fprintf(fid,'%s\n','\parabola[linewidth=2pt,linecolor=black,linestyle=dashed,dash=5mm 1mm](0,0)(0.5,1)');
fprintf(fid,'%s\n',the_circle); 
fprintf(fid,'%s\n',the_arrow); 
fprintf(fid,'%s\n','\rput{0}(1.05,0){\LARGE$X$}');
fprintf(fid,'%s\n','\rput{0}(0,1.05){\LARGE$Y$}');
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

! convert -delay 10 -loop 0 frame*.gif movimento_projectilR.gif
! animate movimento_projectilR.gif
! rm frame*.gif *.aux *.log *.dvi *.ps frame.pdf frame.tex
