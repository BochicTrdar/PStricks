#***************************************************************************************
# First version: 30/04/2010
# 
# Contact: orodrig@ualg.pt
# 
# Circular motion animation with python, image magick, pstricks and swftools
# 
#***************************************************************************************

from scipy import *
from pylab import *
import os

nframes = 5

latex_frame = 'latex frame'
dvips_frame = 'dvips -o frame.ps frame.dvi'
pdf_frame   = 'ps2pdf frame.ps'
crop_frame  = 'pdfcrop frame.pdf'
merge_frames = 'c:\programs\swftools\pdftk frame??.pdf cat output frames.pdf'

dtheta = 2*pi/nframes
theta  = arange(0,2*pi,dtheta) 
theta2 = theta + pi/2

x = 0.7*cos( theta ) 
y = 0.7*sin( theta ) 

x2 = 0.3*cos( theta2 ) 
y2 = 0.3*sin( theta2 ) 

x3 = x + x2;
y3 = y + y2;

for i in arange(0,nframes): 

     fid = open('frame.tex','w')

     circle_coords = 'slopesteps=25](' +str(x[i])+ ','+str(y[i])+'){0.05}'
     vector_coords = '\psline[linewidth=4pt,linecolor=red]{->}'
     vector_coords = vector_coords+'('+str(x[ i])+','+str(y[ i])+')'
     vector_coords = vector_coords+'('+str(x3[i])+','+str(y3[i])+')'

     fid.write('\\documentclass[12pt]{article}\n')
     fid.write('\\pagestyle{empty}\n') 
     fid.write('\\usepackage{pst-all}\n')
     fid.write('\\usepackage{pst-slpe}\n')
     fid.write('\\begin{document}\n') 
     fid.write('\\null\\vskip4cm\n')
     fid.write('\\begin{center}\n') 
     fid.write('\\begin{pspicture}(-1.1,0)(1.1,1.1)\n')
     fid.write('\\psset{unit=8cm}\n')
     fid.write('\\pscircle[linewidth=3pt,linecolor=black,linestyle=dashed,dash=5mm 1mm](0,0){0.7}\n')
     fid.write('\\psline[linewidth=3pt,linecolor=blue]{->}(-1,0)(1,0)\n')
     fid.write('\\psline[linewidth=3pt,linecolor=blue]{->}(0,-1)(0,1)\n')
     fid.write(vector_coords+'\n')
     fid.write('\\rput{0}(1.05,0){\\psscaleboxto(0.06,0.06){$X$}}\n')
     fid.write('\\rput{0}(-0.05,0.95){\psscaleboxto(0.06,0.06){$Y$}}\n')
     fid.write('\\pscircle[linewidth=0.1mm,\n')
     fid.write('linecolor=gray,\n')
     fid.write('fillstyle=ccslope,\n')
     fid.write('slopebegin=lightgray,\n')
     fid.write('slopeend=black,\n')
     fid.write('slopecenter=0.65 0.65,')
     fid.write(circle_coords+'\n')
     fid.write('\\end{pspicture}\n')
     fid.write('\\end{center}\n')
     fid.write('\\end{document}\n') 

     fid.close()

     os.system(latex_frame)
     os.system(dvips_frame)
     os.system(pdf_frame)
     os.system(crop_frame)
     
     if i < 11:
          frame_num = '0'+str(i)
     else:
         frame_num = str(i)
     save_frame = 'cp frame-crop.pdf frame'+frame_num+'.pdf'

     os.system(save_frame)
     os.system(merge_frames)
