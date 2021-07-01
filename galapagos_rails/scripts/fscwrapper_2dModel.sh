#! /bin/bash
#$ -cwd
#$ -l h_rt=20:00:00,h_data=10G
#$ -N Birds2D
#$ -o /u/scratch/p/pkalhori/fastsimcoal/reports
#$ -e /u/scratch/p/pkalhori/fastsimcoal/reports
#$ -m abe
#$ -M pkalhori
#$ -t 1:50

#RWBL_TRBL_jointMAFpop1_0.obs
deme0="TRBL"
deme1="RWBL"
pops="${deme1}_${deme0}"
models="2D.2Epoch 2D.2Epoch.Mig"
rundate=`date +%Y%m%d`
#this is the string of populations to loop through
# wd stands for "working directory"
gitdir=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/github_repos/bird_inference
wd=/u/scratch/p/pkalhori/fastsimcoal/bird_data
md=$gitdir/modeldir
fsc=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/software/fsc26_linux64/fsc26
for model in $models
#iterate through each model
do
for pop in $pops
#iterate through each population
do
cd $wd
header=${model}_${pop}_$rundate
mkdir $header
cd $header
cp $md/$model.tpl ${model}_${pop}.tpl
cp $md/$model.est ${model}_${pop}.est
cp $gitdir/SFSdir/${pop}_jointMAFpop1_0.obs ${model}_${pop}_jointMAFpop1_0.obs
mkdir $wd/$header/run_${SGE_TASK_ID}
cd $wd/$header/run_${SGE_TASK_ID}
cp $wd/$header/${model}_${pop}.tpl $wd/$header/${model}_${pop}.est $wd/$header/${model}_${pop}_jointMAFpop1_0.obs ./
#ss0=`grep -w $deme0 $wd/projectionValues.txt|awk '{print$2}'`
#sed -i "s/SAMPLE_SIZE_0/$ss0/g" ${model}_${pop}.tpl
#ss1=`grep -w $deme1 $wd/projectionValues.txt|awk '{print$2}'`
#sed -i "s/SAMPLE_SIZE_1/$ss1/g" ${model}_${pop}.tpl
$fsc -t ${model}_${pop}.tpl -n100000 -m -e ${model}_${pop}.est -M -L 50 
done
done
cd $wd
sleep 10m 


