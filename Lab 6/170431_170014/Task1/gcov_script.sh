python3 gcov.py

echo "*****Generating Plot*****"

echo "library(methods)" >R_script
echo "branch_data <- read.csv(\"profile_information_branch.csv\")" >> R_script
echo "library(ggplot2)" >> R_script
echo "p0 <- ggplot(data=branch_data,aes(x=branch_number,y=branch_bias))" >> R_script
echo "p1 <- p0+geom_line(color=branch_data\$case_number)+facet_grid(case_number~.)" >> R_script
echo "p2 <- p0+geom_bar(stat=\"identity\",color=branch_data\$case_number,fill=branch_data\$case_number)+facet_grid(case_number~.)" >> R_script
echo "p1" >> R_script
echo "p2" >> R_script
Rscript R_script
