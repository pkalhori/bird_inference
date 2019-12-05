wd=/u/scratch/p/pkalhori/fastsimcoal/bird_data
models="2D.2Epoch 2D.2Epoch.Mig"
pops="RWBL_TRBL"
#muts="4.6e-9"
rundate=20191203
for model in $models
do
for pop in $pops
do
#for mut in $muts
#do
outfile=$wd/${model}_${pop}_${rundate}.all.output.concatted.txt
#get header:
header=`head -n1 $wd/${model}_${pop}_${rundate}/run_1/${model}_${pop}/*bestlhoods`
echo -e "runNum\t$header" > $outfile
for i in {1..50}
do 
outdir=$wd/${model}_${pop}_${rundate}/run_${i}/${model}_${pop}
results=`grep -v [A-Z] $outdir/*.bestlhoods`
echo -e "${i}\t$results" >> $outfile
done
done
#done
done
