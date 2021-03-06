import neurolab
import numpy
import csv

cr = csv.reader(open("master_list_no_name.csv","rb"))
inputs = []
targets = []
for row in cr:
    inputs.append(row[:-1])
    targets.append(row[-1:])

inputs = inputs[1:]
targets = targets[1:]

num_nodes = 5
net = neurolab.net.newff([[1, 40000], 
    [1, 20000],
    [1, 16000], 
    [1, 4000], 
    [1, 4000], 
    [1, 3000], 
    [60, 95], 
    [0, 12], 
    [0, 20], 
    [0, 10], 
    [0, 10]],
    [num_nodes, 1])

err = net.train(inputs, targets, epochs=5000, show=5, goal=.2)


print net.sim([[
17253,11901,1328,958,750,40,84,1,1,0,0
        ]])

