%macro new_function2();
    %let CURRENT_DATE = %sysfunc(date());
    %let SUCCESS = 0;
    %let DATE_FROM_FILE = "";
	
    %get_date();
    %check_dates();

    %let START_TIME = %sysfunc(time());
	%let STOP_TIME = %sysfunc(intnx(minute, &START_TIME, 1)); /* Max time for new tries: 1 minute */
	%let DIFFERENCE = 1; /* Dummy value to enter into do-while-loop */

	%put [x] [START_TIME] = &START_TIME;
	%put [x] [STOP_TIME]  = &STOP_TIME;

	%do %while (&DIFFERENCE > 0);
        %put [x] [SUCCESS] = &SUCCESS;
        
        %if &SUCCESS = 1 %then %do;
            %put [x] PROGRAM SUCCESSFULLY ENDED (WHILE);
            %return;
        %end;

	    %let CURRENT_TIME_CHECK = %sysfunc(time());
	    %let DIFFERENCE = %sysfunc(intck(minute, &CURRENT_TIME_CHECK, &STOP_TIME));
        %put [x] [DIFFERENCE] = &DIFFERENCE;
	    
        %get_date();
        %check_dates();
		
        %let rc = %sysfunc(sleep(20 * 1, 1)); /* How often to do new tries: every 20 second */
	%end;

    %final_check();

%mend;



%macro get_date();
    data _null_;
	    infile "/sas/dwh/time.txt";
	    input
		    date_from_file : ddmmyy10.
        ;
        call symput('DATE_FROM_FILE', date_from_file);
        %put [x] Current [DATE_FROM_FILE] = &DATE_FROM_FILE;
    run;
%mend;



%macro check_dates();
    %put [x] [CURRENT_DATE]   = &CURRENT_DATE;
    %put [x] [DATE_FROM_FILE] = &DATE_FROM_FILE;

    %if &DATE_FROM_FILE = &CURRENT_DATE %then %do;
        %let SUCCESS = 1;
        %put [x] [SUCCESS] = &SUCCESS;
        %return;
    %end;
%mend;



%macro final_check();
    %if &DATE_FROM_FILE = "" %then %do;
        %put ERROR: FILE IS EMPTY;
        %abort;
    %end; %else %if &CURRENT_DATE > &DATE_FROM_FILE %then %do;
        %put ERROR: CURRENT DATE > DATE FROM FILE;
        %abort;
    %end; %else %if &CURRENT_DATE < &DATE_FROM_FILE %then %do;
        %put ERROR: CURRENT DATE < DATE FROM FILE;
        %abort;
    %end; %else %if &CURRENT_DATE = &DATE_FROM_FILE %then %do;
        %put [x] PROGRAM SUCCESSFULLY ENDED (FINAL CHECK);
        %return;
    %end; %else %do;
        %put ERROR: UNEXPECTED ERROR OCCURED;
        %abort;
    %end;
%mend;


%new_function2();