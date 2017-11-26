# Recmat
recommendation matlab code, with GPU supported

## Implemented Algorithms
iRec, uRec, sRec
coSim, cSLIM, SLIM

## sample run
run('iRec', 'beta', 0.1, 'miter', 20, 'datadir') // basic

run('iRec', 'beta', 0.1, 'miter', 20, 'GPU', 1) // utilize GPU

run('iRec', 'beta', 0.1, 'miter', 20, 'datadir', '/home/ychen/dataset/test/') // specify the dataset dir path
