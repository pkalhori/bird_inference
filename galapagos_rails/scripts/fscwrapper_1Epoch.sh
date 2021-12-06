#! /bin/bash
#$ -cwd
#$ -l h_rt=2:00:00,h_data=1G
#$ -N RailInference
#$ -o /u/scratch/p/pkalhori/rails/fastsimcoal
#$ -e /u/scratch/p/pkalhori/rails/fastsimcoal
#$ -m abe
#$ -M pkalhori
#$ -t 1-50:1

muts="1.5e-8"
#samples="14"
contraction_times="5 10 100 500 1000 10000 100000"
#pops
models="1D.2Epoch.FixedT" 
rundate=`date +%Y%m%d`
#this is the string of populations to loop through
# wd stands for "working directory"
wd=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/github_repos/bird_inference/galapagos_rails
md=$wd/modeldir
SFSdir=$wd/SFSdir
fsc=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/software/fsc26_linux64/fsc26
outdir=/u/scratch/p/pkalhori/rails/inference/
mkdir -p $outdir
for model in $models
do
for contraction_time in $contraction_times
do
#iterate through each model
for mut in $muts
do
##try bothh mutatioon rates
#for sample in $samples
#iterate through different SFS sizes
#do
cd $outdir
pop=PIN
header=${model}.${contraction_time}_${pop}_${mut}_$rundate
mkdir $header
cd $header
cp $md/$model.tpl ${model}_${pop}.tpl
cp $md/$model.est ${model}_${pop}.est
cp $wd/SFSdir/${pop}_MAFpop0.obs ${model}_${pop}_MAFpop0.obs
mkdir $outdir/$header/run_${SGE_TASK_ID}
cd $outdir/$header/run_${SGE_TASK_ID}
cp $outdir/$header/${model}_${pop}.tpl $outdir/$header/${model}_${pop}.est $outdir/$header/${model}_${pop}_MAFpop0.obs ./
ss=`grep $pop $wd/projectionValues.txt|awk '{print$2}'`
sed -i "s/MUT/$mut/g" ${model}_${pop}.tpl
sed -i "s/SAMPLE_SIZE/$ss/g" ${model}_${pop}.tpl
sed -i "s/CONTRACTION_TIME/$contraction_time/g" ${model}_${pop}.tpl
$fsc -t ${model}_${pop}.tpl -n100000 -m -e ${model}_${pop}.est -M -L 50 -q
done
done
done
#done
cd $wd
sleep 2m 


