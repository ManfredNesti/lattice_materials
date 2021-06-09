#!/bin/bash
mkdir results;
STR=$(date '+%Y-%m-%d_%H-%M-%S');
mkdir results/$STR;
mkdir results/$STR/code/;
FreeFem++ main.edp 2>&1 | tee results/$STR/output.txt;
wait;
# for f in results/*.ps
# do
#   ps2png results/$f $f.png
# done
# mv results/*.png results/$STR;
cp *.edp results/$STR/code/;
sed -n '/savemesh/,$p' results/$STR/output.txt > results/$STR/output_clean.txt;
mv results/*.vtk results/$STR;
mv results/*.ps results/$STR;
mv results/*.msh results/$STR;
mv results/*.txt results/$STR;

rm ipopt.out;
echo "*** SCRIPT NORMAL END ***";
