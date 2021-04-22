#!/bin/bash

# configure variables
t1=`jq -r '.t1' config.json`
t2=`jq -r '.t2' config.json`
crop=`jq -r '.crop' config.json`
dof=`jq -r '.dof' config.json`
cost=`jq -r '.cost' config.json`
volumes="t1 t2"

# make output directory
[ ! -d ./output ] && mkdir -p output

# crop t2 if true. else copy
if [[ ${crop} == 'true' ]]; then
	robustfov -i ${t2} -r t2.nii.gz
else
	cp ${t2} ./t2.nii.gz
fi

# copy t1
cp ${t1} ./t1.nii.gz

# computing brainmask
for i in ${volumes}
do
	# create brainmask
	bet ${i}.nii.gz ${i}_brain -R -m
done

# compute transformation matrix between t2 and t1
echo "computing transform between t2 and t1"
flirt -in t2_brain.nii.gz -ref t1_brain.nii.gz -dof ${dof} -cost ${cost} -omat t2tot1.mat

# applying transform
echo "applying transform to t2"
flirt -in t2.nii.gz -ref t1_brain.nii.gz -init t2tot1.mat -applyxfm -out ./output/t2.nii.gz

# catch output if missing
if [ ! -f ./output/t2.nii.gz ]; then
	echo "something went wrong. check derivatives"
	exit 1
else
	echo "complete!"
	rm -rf *.nii.gz *.mat
	exit 0
fi
