#!/bin/bash
QCdir=$PWD

killall -9 o2-qc
killall -9 o2-dpl-raw-proxy
sleep 1
tmux send-keys -t qc-its:2 'C-c'
tmux send-keys -t qc-its:2 'C-c'

sleep 2
tmux send-keys -t qc-its:3 'C-c'
tmux send-keys -t qc-its:3 'C-c'

sleep 2
tmux send-keys -t qc-its:3 "kill -9 $(ps -ef | grep 'readout.exe file://${QCdir}/readout_replay.cfg' | grep -v 'grep' |  awk '{ printf $2 }')" Enter

echo "QC processes killed"
#sleep 2

#tmux send-keys -t qc-ib:qc-task 'fairmq-shmmonitor --cleanup --session defaultll' Enter
