#                  Create a new job

1. Create an SSH-script (`job_to_add.sh` in that case) from a template:
```BASH
#BSUB -J Job_Name
#BSUB -L /bin/bash
#BSUB -W 2:00               #Max Time (Stops after reaching) in HH:MM
#BSUB -n 4                  #Number of cores
#BSUB -R "span[ptile=1]"    #Number of cores per node
#BSUB -R "rusage[mem=5000]" #Number of CPU (in MB)
#BSUB -M 5000               #Limit of memory (must be equal to previous line)
#BSIB -o stdout.%J          #Send [STDOUT] to [stdout.%jobID%]
#BSIB -e stderr.%J          #Send [STDERR] to [stderr.%jobID%]

#BSUB -u tabogdanov@mts.ru  #Send emails to this mail
#BSUB -B -N                 #[-B] means 'send email on the start of a job'. [-N] means 'send email on the end of job'
ls -l
cd ..
ls -l
```
2. `bsub < job_to_add.sh`