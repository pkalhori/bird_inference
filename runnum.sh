wd=/u/home/p/pkalhori/project-klohmueldata/pooneh_data/bird_inference
models="1D.2Epoch.LongT"
pops="All.38"
muts="4.6e-9"
rundate=20191113
for model in $models
do
for pop in $pops
do
for mut in $muts
do
outfile=$wd/${model}_${pop}_${mut}_${rundate}.all.output.concatted.txt
#get header:
header=`head -n1 $wd/${model}_${pop}_${mut}_${rundate}/run_11/${model}_${pop}/*bestlhoods`
echo -e "runNum\t$header" > $outfile
for i in {1..50}
do 
outdir=$wd/${model}_${pop}_${mut}_${rundate}/run_${i}/${model}_${pop}
results=`grep -v [A-Z] $outdir/*.bestlhoods`
echo -e "${i}\t$results" >> $outfile
done
done
done
done
