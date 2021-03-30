# QCUtils
ITS QC quick start

## Run QC via FLP suite (decicated to FW development)
1. `cd workdir`
2. Configuration
   - Change the raw data path to the raw file you need to replay in the [readout.exe cfg](https://github.com/JianLIUhep/QCUtils/blob/e9670b38dbf0a698468ff8c73da3963c69488772/workdir/readout_replay.cfg#L48).
   - Change the data sampling rate in qc jsons for [Fhr](https://github.com/JianLIUhep/QCUtils/blob/e9670b38dbf0a698468ff8c73da3963c69488772/workdir/itsFhr.json#L71) and [Fee](https://github.com/JianLIUhep/QCUtils/blob/master/workdir/itsFee.json) tasks. The default value is 1, namely all payloads will be sent to QC. 
4. Run the qc script followed by a QC task name (e.g. Fhr or Fee):<br>
`./run_QC_task.sh Fee`
<br>Fhr: Fake-hit rate<br>
Fee: Front-end electronics<br>
The qc logfiles can be found under `workdir/log/`. <br>
To restart a new run (replaying a new file), simply rerun above the command. If one wants to kill all qc related processes, please run:<br>
`kill_qc.sh`<br>
A tmux session named `qc-its` will be created with 4 windows
   - window 0: general 
   - window 1: qc task
   - window 2: StfBuilder
   - window 3: readout.exe
5. Checking the results via [CCDB](http://ccdb-test.cern.ch:8080/browse/qc/ITS/MO?report=true) and [QCG](https://qcg-test.cern.ch/?page=objectTree)
The paths in CCDB and QCG are **/qc/ITS/MO/FHRTaskFW** and **qc/ITS/MO/ITSFeeFW** for the Fhr and Fee tasks, respectively. <br> To created a QC layout in the QCG: 
   - on the left side, click "+" of "MY LAYOUTS" to create a new layout with a name
   - click the drop-down list on the left side and select qc/ITS/MO/YOUR_TASK_NAME
   - then double click the histogram you want to add
   - now you have a plot in your layout. Click the canvas, you can change the size and options. 

