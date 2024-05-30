%LET sasServ      = remote.sas.server.com 55551;
%LET USERID       = linuxUserName;     /* SAS special variable */
%LET PASSWORD     = linuxUserPassword; /* SAS special variable */
%LET SASSTARTUP   = /sas/bin/sas94/SASFoundation/9.4/sas -dmr -comamid tcp -device grlink -noterminal;

OPTIONS
    COMAMID = TCP     /* Protocol to connect to a remote SAS-server */
    REMOTE  = sasServ /* FQDN of the remote server */
;

/* File on this server that will sign us on the remote SAS server */
FILENAME rlink "/sas/home/tabogdanov/tcpunix.scr";

SIGNON sasServr; /* Connects to a remote SAS-server */

LIBNAME Remote1
    CLEAR
;
LIBNAME Remote1 /* Link to the library on the remote SAS-server */
    SLIBREF = WORK /* Library name on remote SAS-server */
    SERVER  = sasServr
;

RSUBMIT; /* This code will be executed on the remote SAS-server */
    DATA WORK.TestTable1;/* Actually, it's LinkToRemoteSasLibrary.TestTable1 */
	    INPUT
		    column1
	    ;
        DATALINES;
        1
        2
        3
        4
        5
    RUN;
ENDRSUBMIT;

OPTIONS
    LINESIZE = MAX
    PAGESIZE = MAX
    NOCENTER
    NOLABEL
    NONUMBER
    NODATE
;

PROC PRINT
    DATA = Remote1.TestTable1
    NOOBS
    WIDTH = MIN;
RUN;