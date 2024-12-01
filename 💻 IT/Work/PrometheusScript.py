from prometheus_client import start_http_server, disable_created_metrics, Counter, Gauge, Summary, Histogram, Info, Enum
import time
import prometheus_client

# v-- Disable stupid metrics
disable_created_metrics()
prometheus_client.REGISTRY.unregister(prometheus_client.GC_COLLECTOR)
prometheus_client.REGISTRY.unregister(prometheus_client.PLATFORM_COLLECTOR)
prometheus_client.REGISTRY.unregister(prometheus_client.PROCESS_COLLECTOR)
# ^-- Disable stupid metrics




# v-----------------------------------------------------------------------------------------------------------VARIABLES
# v-- Creation of the Gauge for the SAS-GreenPlum copying system tasks
sasGreenplumCopyingGauge = Gauge('mis_dwh_sas_greenplum_copying_tasks',
                                 'Copying System from SAS to GreenPlum: tasks',
                                 ['step', 'status']
)

arrayOfCopySteps = ["SAS-STG",
                    "STG-BAS"
]
arrayOfStatuses  = ["RUNNING_0-24_HOURS",
                    "RUNNING_24+_HOURS",
                    "RUNNING_72+_HOURS",
                    "PENDING_0-24_HOURS",
                    "PENDING_24+_HOURS",
                    "PENDING_72+_HOURS",
                    "ERRORs_IN_LAST_24_HOURS"
] #? CANCELLED_EARLIER_ON_THIS_WEEK also there, but it is only for STG-BAS

for currentStep in arrayOfCopySteps : #? Initialize all lables to 0s
    for currentStatus in arrayOfStatuses :
        sasGreenplumCopyingGauge.labels(step   = currentStep,
                                        status = currentStatus
        ).set(0)
sasGreenplumCopyingGauge.labels(step   = "STG-BAS",
                                status = "CANCELLED_EARLIER_ON_THIS_WEEK"
).set(0)
# ^-- Creation of the Gauge for the SAS-GreenPlum copying system tasks





# v-- Creation of the Gauge for the SAS-GreenPlum copying system sessions
sasGreenplumSessionsGauge = Gauge('mis_dwh_sas_greenplum_copying_sessions',
                                  'Copying System from SAS to GreenPlum: sessions',
                                  ['time', 'state', 'type']
)

arrayOfTypes  = ["???", "SAS_TO_UAT_T_STG", "UAT_T_STG_TO_UAT_T_BASE"]
arrayOfTime   = ["0-24_HOURS", "24+_HOURS", "72+_HOURS"]
arrayOfStates = ["active", "idle_in_transaction"]

for currentType in arrayOfTypes : #? Initialize all lables to 0s
    for currentTime in arrayOfTime :
        for currentState in arrayOfStates :
            sasGreenplumSessionsGauge.labels(time  = currentTime,
                                             state = currentState,
                                             type  = currentType
            ).set(0)
# ^-- Creation of the Gauge for the SAS-GreenPlum copying system sessions





# v-- Creation of the Gauge for the SAS-GreenPlum copying system diskspace
sasGreenplumDiskspaceGauge = Gauge('mis_dwh_greenplum_diskspace',
                                   'Diskspace of GreenPlum claster',
                                   ['schema', 'which']
)

arrayOfSchemas = ["uat_etl_meta", "uat_t_base", "uat_t_stg"]

for currentSchema in arrayOfSchemas : #? Initialize all lables to 0s
    sasGreenplumDiskspaceGauge.labels(schema = currentSchema,
                                      which  = "all"
    ).set(0)
    sasGreenplumDiskspaceGauge.labels(schema = currentSchema, 
                                      which  = "used"
    ).set(0)
# ^-- Creation of the Gauge for the SAS-GreenPlum copying system diskspace




# ^-- Creation of the Gauge for Exportilka
exportilkaGauge = Gauge('mis_dwh_exportilka_tasks',
                        'Exportilka: tasks',
                        ['pool', 'status']
)

for iterator in range(0, 4) : #? Initialize all lables to 0s
    for currentStatus in arrayOfStatuses :
        exportilkaGauge.labels(
            pool   = iterator, 
            status = currentStatus
        ).set(0)
# ^-- Creation of the Gauge for Exportilka
# ^-----------------------------------------------------------------------------------------------------------VARIABLES




# v-----------------------------------------------------------------------------------------------------------FUNCTIONS
def sasGreenplumCheckTasks(given_file):
    with open(given_file) as sasGp:
        for line in sasGp:
            line = " ".join(line.split()) #? Removes multiple spaces
            if line == '':                #? Skip blank lines
                next
            arrayOfWords     = line.split(" ")
            firstWord        = arrayOfWords[0]
            possibleCopyStep = firstWord[0:7]
            if possibleCopyStep in arrayOfCopySteps :
                status           = firstWord[8:]
                numberOfStatuses = arrayOfWords[1]
                sasGreenplumCopyingGauge.labels(step = possibleCopyStep,
                                                status = status
                ).set(numberOfStatuses)
            elif possibleCopyStep == "EXPRTLK" :
                status           = firstWord[8:]
                pool             = arrayOfWords[1]
                numberOfStatuses = arrayOfWords[2]
                exportilkaGauge.labels(pool = pool,
                                       status = status
                ).set(numberOfStatuses)




def sasGreenplumCheckSessions():
    with open('sas_gp.txt') as sasGp:
        for line in sasGp:
            line = " ".join(line.split()) # Removes multiple spaces
            if line == '':
                next
            arrayOfWords = line.split(" ")
            if arrayOfWords[0] in arrayOfTime :
                time = arrayOfWords[0]
                state = arrayOfWords[1]
                type = arrayOfWords[2]
                numberOfSessions = arrayOfWords[3]
                sasGreenplumSessionsGauge.labels(
                    time = time,
                    state = state,
                    type = type
                ).set(numberOfSessions)




def sasGreenplumCheckDiskspace():
    with open('sas_gp.txt') as sasGp:
        for line in sasGp:
            line = " ".join(line.split()) # Removes multiple spaces
            if line == '':
                next
            arrayOfWords = line.split(" ")
            if arrayOfWords[0] in arrayOfSchemas :
                schema = arrayOfWords[0]
                used   = arrayOfWords[2]
                all    = arrayOfWords[4]
                sasGreenplumDiskspaceGauge.labels(
                    schema = schema,
                    which  = "all"
                ).set(all)
                sasGreenplumDiskspaceGauge.labels(
                    schema = schema,
                    which  = "used"
                ).set(used)
# ^-----------------------------------------------------------------------------------------------------------FUNCTIONS




# v-----------------------------------------------------------------------------------------------------------  PROGRAM
if __name__ == '__main__':
    start_http_server(55551)
    while True: #? Calls [process_request()] single-threadly. How often depends on [time.sleep()]
        time.sleep(5) # How often to gather metrics (in seconds)
        # v-- Copy-system from SAS to Greenplum
        sasGreenplumCheckTasks("sas_gp.txt")
        sasGreenplumCheckSessions()
        sasGreenplumCheckDiskspace()
        # ^-- Copy-system from SAS to Greenplum

        # v-- Exportilka
        sasGreenplumCheckTasks("exportilka.txt")
        # ^-- Exportilka
# ^-----------------------------------------------------------------------------------------------------------  PROGRAM