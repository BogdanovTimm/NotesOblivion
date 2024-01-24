%let DWL_TODAY = 23399;

%macro mPdftCheck;
    %let PdftLoadDate = .;
    %if "&DWL_TODAY" = "" %then %do;
        %put ERROR: Parameter DWL_TODAY not defined.;
        %abort;
    %end;
    
    %let START_TIME = %sysfunc(time());
    %let STOP_TIME = %sysfunc(intnx(minute, &START_TIME, 2)); /* 2 minutes */
    %let DIFFERENCE = 1; /* Dummy value to enter into do-while-loop */


    %do %while (&DIFFERENCE > 0);
        filename PdftDate "/sas/dwh/date.txt";
        data _null_;
            infile PdftDate;
            input Date $ 1-10;
            call symput ('PdftLoadDate', Date);
        run;
        %let PdftLoadDate=%sysfunc(inputn(&PdftLoadDate, DDMMYY10.));

        %put date from file is equal to &PdftLoadDate;
        %put current date is &DWL_TODAY; 
        
        %if &PdftLoadDate = &DWL_TODAY %then %do;
            %put Program Successfully Ended;
            %return;
        %end;
        
        %let rc = %sysfunc(sleep(15 * 1, 1)); /* 15 seconds */
        
        %let CURRENT_TIME_CHECK = %sysfunc(time());
        %let DIFFERENCE = %sysfunc(intck(minute, &CURRENT_TIME_CHECK, &STOP_TIME));
    %end;


    
    %if &PdftLoadDate = . %then %do;
        %put ERROR: File either empty or contains incorrect data;
        %abort;
    %end; %else %if &DWL_TODAY > &PdftLoadDate %then %do;
        %put ERROR: Current date > Date from file;
        %abort;
    %end; %else %if &DWL_TODAY < &PdftLoadDate %then %do;
        %put ERROR: Current date < Date from file;
        %abort;
    %end; %else %if &DWL_TODAY = &PdftLoadDate %then %do;
        %put Program Successfully Ended;
        %return;
    %end; %else %do;
        %put ERROR: Enexpected Error;
        %abort;
    %end;

%mend;

%let DWL_TODAY = 23399;
%put current date is &DWL_TODAY;

%mPdftCheck;