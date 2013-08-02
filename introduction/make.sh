cd ~/Github/esa_data_viz/Intro_lecture
rm ggplot.tex
Rscript -e "library(knitr); knit('ggplot.Rnw', quiet = TRUE)"
pdflatex ggplot.tex
open ggplot.pdf
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.vrb
rm *.aux
# can comment out these two lines if necessary for rebuilding
rm -r cache
rm -r figure
# added a comment.
