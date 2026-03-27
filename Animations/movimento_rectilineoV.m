%***************************************************************************************
% First version: 19/04/2008
% 
% Contact: orodrig@ualg.pt
% 
% Generating an animation using pstricks. 
% 
%***************************************************************************************

nframes = 37; 

dr = 0.3; 

P = [-0.9  0   ];
Q = [ 0.75 0.85];

k = ( Q(2) - P(2) )/( Q(1) - P(1) ); theta = atan( k ); 

x = linspace(P(1),Q(1),nframes);

y = k*( x - P(1) ) + P(2);  

for i = 1:nframes 

fid = fopen('frame.tex','w');

the_arrowV = [ '\psline[linewidth=5pt,linecolor=red]{->}('  num2str(x(i)) ',' num2str(y(i)) ')' ... 
'(' num2str(x(i)+dr*cos(theta)) ',' num2str(y(i)+dr*sin(theta)) ')']; 

the_line  = [ '\psline[linewidth=2pt,linecolor=black,linestyle=dashed,dash=5mm 1mm]' ...
'(' num2str(x(1)) ',' num2str(y(1)) ')' ...
'(' num2str(x(i)) ',' num2str(y(i)) ')' ];

the_circle = [ '\pscircle[fillstyle=solid,fillcolor=blue](' num2str(x(i)) ',' num2str(y(i)) '){0.02}' ];

fprintf(fid,'%s\n','\documentclass[12pt]{article}');
fprintf(fid,'%s\n','\pagestyle{empty}');
fprintf(fid,'%s\n','\input{/home/orodrig/TeXdoc/Tools/newcmds}'); 
fprintf(fid,'%s\n','\usepackage{pst-all}'); 
fprintf(fid,'%s\n','\begin{document}'); 
fprintf(fid,'%s\n','\null\vskip10cm');
fprintf(fid,'%s\n','\bec');
fprintf(fid,'%s\n','\begin{pspicture}(-1.1,0)(1.1,1.1)');
fprintf(fid,'%s\n','\psset{unit=8cm}');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{->}(-1,0)(1,0)');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{->}(0,0)(0,1)');
if i > 1 
fprintf(fid,'%s\n',the_line);
end
fprintf(fid,'%s\n',the_circle); 
fprintf(fid,'%s\n',the_arrowV); 
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

! convert -delay 10 -loop 0 frame*.gif movimento_rectilineoV.gif
! animate movimento_rectilineoV.gif
! rm frame*.gif *.aux *.log *.dvi *.ps frame.pdf frame.tex
