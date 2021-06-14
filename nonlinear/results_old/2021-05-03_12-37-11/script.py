import os

tag = "while(stopmesh"
lines_to_write = []
tag_found = False

cwd = "/home/manfred/Desktop/lattice_materials/nonlinear/results_old"

with open('output.txt',encoding="utf8") as in_file:
    for line in in_file:
        print(line.strip())
        if line.strip() == tag:
            tag_found = True
        if tag_found:
            lines_to_write.append(line)
with open('output_clean.txt','w',encoding="utf8") as out_file:
    out_file.writelines(lines_to_write)
