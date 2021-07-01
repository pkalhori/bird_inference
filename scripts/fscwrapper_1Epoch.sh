#! /bin/bash
#$ -cwd
#$ -l h_rt=20:00:00,h_data=1G
#$ -N FscBirds3Epoch
#$ -o /u/scratch/p/pkalhori/fastsimcoal/reports
#$ -e /u/scratch/p/pkalhori/fastsimcoal/reports
#$ -m abe
#$ -M pkalhori
#$ -t 1-50:1

muts="4.6e-9"
samples="38"
models="1D.3Epoch" 
rundate=`date +%Y%m%d`
#this is the string of populations to loop through
# wd stands for "working directory"
wd=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/bird_inference
gitdir=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/github_repos/bird_inference
fsc=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/software/fsc26_linux64/fsc26
for model in $models
#iterate through each model
do
for mut in $muts
do
##try bothh mutatioon rates
for sample in $samples
#iterate through different SFS sizes
do
cd $wd
pop=All.$sample
header=${model}_${pop}_${mut}_$rundate
mkdir $header
cd $header
cp $gitdir/modeldir/$model.tpl ${model}_${pop}.tpl
cp $gitdir/modeldir/$model.est ${model}_${pop}.est
cp $gitdir/SFSdir/${pop}_MAFpop0.obs ${model}_${pop}_MAFpop0.obs
mkdir $wd/$header/run_${SGE_TASK_ID}
cd $wd/$header/run_${SGE_TASK_ID}
cp $wd/$header/${model}_${pop}.tpl $wd/$header/${model}_${pop}.est $wd/$header/${model}_${pop}_MAFpop0.obs ./
#ss=`grep $pop $wd/projectionValues.txt|awk '{print$2}'`
sed -i "s/MUT/$mut/g" ${model}_${pop}.tpl
sed -i "s/SAMPLE_SIZE/$sample/g" ${model}_${pop}.tpl
$fsc -t ${model}_${pop}.tpl -n100000 -m -e ${model}_${pop}.est -M -L 50 -q
done
done
done
cd $wd
sleep 5m 


