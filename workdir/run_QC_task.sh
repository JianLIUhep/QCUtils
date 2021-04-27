#!/bin/bash

timestamp=$(date +%Y-%m-%d_%H-%M-%S)
#QCdir=/home/its/QC_NewFormat/workdir
QCdir=$PWD
QCtask=$1
readout_version=v2.0.2-1
DD_version=v0.10.4-1
QC_version=v1.15.0-6

setEnv() {
  tmux send-keys -t $1:$2  "aliswmod enter $3/$4" Enter
  tmux send-keys -t $1:$2 "sleep $5" Enter
  tmux send-keys -t $1:$2 "cd ${QCdir}" Enter
}

tmux has-session -t 'qc-its'
if [ $? != 0 ];then
  tmux new-session -d -s qc-its

  tmux new-window -d -t qc-its -n qc-task -c ${QCdir}
  setEnv "qc-its" "qc-task" "QualityControl" ${QC_version} 10

  tmux new-window -d -t qc-its -n stfb -c ${QCdir}
  setEnv "qc-its" "stfb" "DataDistribution" ${DD_version} 20

  tmux new-window -d -t qc-its -n ro -c ${QCdir}
  setEnv "qc-its" "ro" "Readout" ${readout_version} 30
  
  sleep 32
else
  ./kill_qc.sh
fi

tmux send-keys -t qc-its:1 'sleep 2' Enter
tmux send-keys -t qc-its:1 "o2-dpl-raw-proxy -b --session qc --dataspec 'filter:ITS/RAWDATA;G:FLP/DISTSUBTIMEFRAME' --channel-config 'name=readout-proxy,type=pull,method=connect,address=ipc:///tmp/stf-builder-dpl-pipe-q,transport=shmem,rateLogging=0' | o2-qc --config json://${QCdir}/its${QCtask}.json -b --session qc  --shm-segment-size 4000000000  > log/qc_${timestamp}.log &" Enter

sleep 5

tmux send-keys -t qc-its:2 'sleep 2' Enter
tmux send-keys -t qc-its:2 'StfBuilder --id stf_builder-0 --transport shmem --detector ITS --detector-rdh 6  --session qc --dpl-channel-name=dpl-chan --channel-config "name=dpl-chan,type=push,method=bind,address=ipc:///tmp/stf-builder-dpl-pipe-q,transport=shmem,rateLogging=0" --input-channel-name readout  --channel-config "name=readout,type=pull,method=connect,address=ipc:///tmp/readout-pipe-q,transport=shmem,rateLogging=0"' Enter


sleep 2

tmux send-keys -t qc-its:3 'sleep 2' Enter
tmux send-keys -t qc-its:3 "readout.exe file://${QCdir}/readout_replay.cfg" Enter


