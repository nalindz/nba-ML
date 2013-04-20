import neurolab
import numpy
import csv

cr = csv.reader(open("master_list_no_name.csv","rb"))
inputs = []
outputs = []
for row in cr:
    input.append(row[:-1])
    outputs.append(row[-1:])

print input
print outputs
