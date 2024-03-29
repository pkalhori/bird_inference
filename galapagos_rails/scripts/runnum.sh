wd=/u/scratch/p/pkalhori/rails/inference
#models="1D.2Epoch.LongT 1D.1Epoch.small 1D.1Epoch.large 1D.3Epoch"
models="1D.2Epoch.FixedT"
pops="PIN"
muts="1.5e-8"
rundate=20211014
contraction_times="5 10 100 500 1000 10000 100000"
for model in $models
do
for contraction_time in $contraction_times
do
for pop in $pops
do
for mut in $muts
do
outfile=$wd/${model}.${contraction_time}_${pop}_${mut}_${rundate}.all.output.concatted.txt
#get header:
header=`head -n1 $wd/${model}.${contraction_time}_${pop}_${mut}_${rundate}/run_1/${model}_${pop}/*bestlhoods`
echo -e "runNum\t$header" > $outfile
for i in {1..50}
do 
outdir=$wd/${model}.${contraction_time}_${pop}_${mut}_${rundate}/run_${i}/${model}_${pop}
results=`grep -v [A-Z] $outdir/*.bestlhoods`
echo -e "${i}\t$results" >> $outfile
done
done
done
done
done
