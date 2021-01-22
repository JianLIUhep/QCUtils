#!/bin/bash

#Cloning packages
#O2
git clone https://github.com/AliceO2Group/AliceO2.git O2
#QC
git clone https://github.com/AliceO2Group/QualityControl.git
#Readout
git clone https://github.com/AliceO2Group/Readout.git
#DataDistribution
git clone https://github.com/AliceO2Group/DataDistribution.git
#alidist
git clone https://github.com/alisw/alidist.git
#alibuild
git clone https://github.com/alisw/alibuild.git
#QCanalysis
git clone https://github.com/iravasen/QCanalysis.git


#Building 
alibuild/aliBuild build O2 QualityControl Readout DataDistribution  --defaults o2 --jobs 8 #One may need to reduce the jobs to < 4 if the RAM is less than 8 GB

