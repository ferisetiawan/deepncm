doexp() {
  x=$1
  dataset=$(echo "$x" | cut -f 1 -d ";" | xargs)
  method=$(echo "$x" | cut -f 2 -d ";" | xargs)
  param=$(echo "$x" | cut -f 3 -d ";" | xargs)
  lr=$(echo "$x" | cut -f 4 -d ";" | xargs)
  logfile="logs/${dataset}_${method}_${param}_${lr}.log"
  cmd="python cifar10_deepncm.py --dataset ${dataset} --ncmmethod ${method} --ncmparam ${param} -l ${lr} >> ${logfile} 2>&1"
  echo ${cmd}
  rm ${logfile}
  eval ${cmd}
}
export -f doexp
cat deepncm_experiments.txt | parallel -P 4 doexp
