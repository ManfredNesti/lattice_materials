#!/bin/bash
mkdir results_case1_non_linear;
STR=$(date '+%Y-%m-%d_%H-%M-%S');
mkdir results_case1_non_linear/$STR;
FreeFem++ main.edp 2>&1 | tee results_case1_non_linear/$STR/output.txt;
wait;
mv results_case1_non_linear/*.vtk results_case1_non_linear/$STR;
rm ipopt.out;
echo "*** SCRIPT NORMAL END ***";
