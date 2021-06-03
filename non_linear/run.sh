#!/bin/bash

echo "----------------------------------------------------";
echo "---      Lattice material optimization with      ---";
echo "---            non linear elastic law            ---";
echo "---                                              ---";
echo "--- Teresa Babini (teresa.babini@mail.polimi.it) ---";
echo "--- Manfred Nesti (manfred.nesti@mail.polimi.it) ---";
echo "----------------------------------------------------";

mkdir results;
STR = $(date '+%Y-%m-%d_%H-%M-%S');
mkdir results/$STR;
mkdir results/$STR/code/;
FreeFem++ main.edp 2>&1 | tee results/$STR/output.txt;
wait;
cp *.edp results/$STR/code/;
sed -n '/savemesh/,$p' results/$STR/output.txt > results/$STR/output_clean.txt;
mv results/*.vtk results/$STR;
mv results/*.ps results/$STR;
mv results/*.msh results/$STR;
mv results/*.txt results/$STR;
rm ipopt.out;

echo "--- Script ended ---";
