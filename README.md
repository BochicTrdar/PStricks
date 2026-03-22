# PStricks
PStricks figures for Math and Physics

To compile afile.tex try 
latex afile 
dvips -o afile.ps afile 
epstopdf afile.ps
pdfcrop.pl afile.pdf
mv afile-crop.pdf afile.pdf
rm afile.ps afile.aux afile.log afile.dvi

Don't like it? Don't use it... 
