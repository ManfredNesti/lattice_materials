#!/bin/bash
mkdir results_case1_non_linear;
STR=$(date '+%Y-%m-%d_%H-%M-%S');
mkdir results_case1_non_linear/$STR;
mkdir results_case1_non_linear/$STR/code/;
FreeFem++ main.edp 2>&1 | tee results_case1_non_linear/$STR/output.txt;
wait;
# for f in results_case1_non_linear/*.ps
# do
#   ps2png results_case1_non_linear/$f $f.png
# done
# mv results_case1_non_linear/*.png results_case1_non_linear/$STR;
cp *.edp results_case1_non_linear/$STR/code/;
sed -n '/savemesh/,$p' results_case1_non_linear/$STR/output.txt > results_case1_non_linear/$STR/output_clean.txt;
mv results_case1_non_linear/*.vtk results_case1_non_linear/$STR;
mv results_case1_non_linear/*.ps results_case1_non_linear/$STR;
mv results_case1_non_linear/*.msh results_case1_non_linear/$STR;
mv results_case1_non_linear/*.txt results_case1_non_linear/$STR;

rm ipopt.out;
echo "*** SCRIPT NORMAL END ***";
