%***************************************************************************************
% Generating an animation using pstricks. 
%***************************************************************************************
clear al, close all

nframes = 37; 

theta  = linspace(0,2*pi,nframes); 
theta2 = theta + pi/2;

x = 0.7*cos( theta ); 
y = 0.7*sin( theta ); 

x( abs(x) <= 2e-16 ) = 0; 
y( abs(y) <= 2e-16 ) = 0; 

x2 = 0.3*cos( theta2 ); 
y2 = 0.3*sin( theta2 ); 

x3 = x + x2;
y3 = y + y2;

for i = 1:nframes 

fid = fopen('frame.tex','w');

circle_coords = [ 'slopesteps=25](' num2str(x(i)) ',' num2str(y(i)) '){0.05}' ];
vector_coords = [ '\psline[linewidth=4pt,linecolor=red]{->}' ];
vector_coords = [ vector_coords '(' num2str(x( i)) ',' num2str(y( i)) ')' ];
vector_coords = [ vector_coords '(' num2str(x3(i)) ',' num2str(y3(i)) ')' ];

fprintf(fid,'%s\n','\documentclass[12pt]{article}');
fprintf(fid,'%s\n','\pagestyle{empty}');
fprintf(fid,'%s\n','\usepackage{pst-all}');
fprintf(fid,'%s\n','\usepackage{pst-slpe}');
fprintf(fid,'%s\n','\begin{document}'); 
fprintf(fid,'%s\n','\null\vskip4cm');
fprintf(fid,'%s\n','\begin{center}'); 
fprintf(fid,'%s\n','\begin{pspicture}(-1.1,0)(1.1,1.1)');
fprintf(fid,'%s\n','\psset{unit=8cm}');
fprintf(fid,'%s\n','\pscircle[linewidth=3pt,linecolor=black,linestyle=dashed,dash=5mm 1mm](0,0){0.7}');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{->}(-1,0)(1,0)');
fprintf(fid,'%s\n','\psline[linewidth=3pt,linecolor=blue]{->}(0,-1)(0,1)');
fprintf(fid,'%s\n',vector_coords);
fprintf(fid,'%s\n','\rput{0}(1.05,0){\psscaleboxto(0.06,0.06){$X$}}');
fprintf(fid,'%s\n','\rput{0}(-0.05,0.95){\psscaleboxto(0.06,0.06){$Y$}}');
fprintf(fid,'%s\n','\pscircle[linewidth=0.1mm,');
fprintf(fid,'%s\n','linecolor=gray,');
fprintf(fid,'%s\n','fillstyle=ccslope,');
fprintf(fid,'%s\n','slopebegin=lightgray,');
fprintf(fid,'%s\n','slopeend=black,');
fprintf(fid,'%s\n','slopecenter=0.65 0.65,');
fprintf(fid,'%s\n',circle_coords);
fprintf(fid,'%s\n','\end{pspicture}');
fprintf(fid,'%s\n','\end{center}');
fprintf(fid,'%s\n','\end{document}'); 

fclose( fid );

system('latex frame');
system('dvips -o frame.ps frame');
system('ps2pdf frame.ps');
system('pdfcrop.pl frame.pdf');
system('mv frame-crop.pdf frame.pdf');
system('mogrify -format gif frame.pdf');

       if i < 11
       eval(['!mv frame.gif frame0' num2str(i-1) '.gif'])
       else
       eval(['!mv frame.gif frame'  num2str( i ) '.gif'])
       end

end 

system('convert -delay 15 -loop 0 frame*.gif movimento_circular.gif');
system('animate movimento_circular.gif');
system('rm frame*.gif *.aux *.log *.dvi *.ps frame.pdf frame.tex');
