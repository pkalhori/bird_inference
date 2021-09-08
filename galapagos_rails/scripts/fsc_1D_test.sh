muts="1.4e-8 1.5e-8"
samples="14"
models="1D.2Epoch" 
rundate=test
#this is the string of populations to loop through
# wd stands for "working directory"
wd=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/bird_inference/galapagos_rails
md=$wd/modeldir
SFSdir=$wd/SFSdir
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
pop=PIN
header=${model}_${pop}_${mut}_$rundate
mkdir $header
cd $header
cp $md/$model.tpl ${model}_${pop}.tpl
cp $md/$model.est ${model}_${pop}.est
cp $wd/SFSdir/${pop}_MAFpop0.obs ${model}_${pop}_MAFpop0.obs
mkdir $wd/$header/run_3
cd $wd/$header/run_3
cp $wd/$header/${model}_${pop}.tpl $wd/$header/${model}_${pop}.est $wd/$header/${model}_${pop}_MAFpop0.obs ./
#ss=`grep $pop $wd/projectionValues.txt|awk '{print$2}'`
sed -i "s/MUT/$mut/g" ${model}_${pop}.tpl
sed -i "s/SAMPLE_SIZE/$sample/g" ${model}_${pop}.tpl
$fsc -t ${model}_${pop}.tpl -n1000 -m -e ${model}_${pop}.est -M -L 50 -q
done
done
done
cd $wd
sleep 2m 


