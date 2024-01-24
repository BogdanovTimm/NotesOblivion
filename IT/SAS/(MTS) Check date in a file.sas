%macro main();
    %let CURRENT_DATE = %sysfunc(date());
    %let SUCCESS = 0;
    %let DATE_FROM_FILE = "";
	
    %get_date();
    %check_dates();

    %let START_TIME = %sysfunc(time());
	%let STOP_TIME = %sysfunc(intnx(minute, &START_TIME, 1)); /* Max time for new tries: 1 minute */
	%let DIFFERENCE = 1; /* Dummy value to enter into do-while-loop */

	%put Start Time = &START_TIME;
	%put Stop Time  = &STOP_TIME;

	%do %while (&DIFFERENCE > 0);        
        %if &SUCCESS = 1 %then %do;
            %put Program Successfully Ended;
            %return;
        %end;

        %get_date();
        %check_dates();
		
        %let rc = %sysfunc(sleep(20 * 1, 1)); /* How often to do new tries: every 20 second */
        
        %let CURRENT_TIME_CHECK = %sysfunc(time());
	    %let DIFFERENCE = %sysfunc(intck(minute, &CURRENT_TIME_CHECK, &STOP_TIME));
        %put Current difference = &DIFFERENCE;
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
        %put Current Date from file = &DATE_FROM_FILE;
    run;
%mend;



%macro check_dates();
    %put Current Date           = &CURRENT_DATE;
    %put Current Date From file = &DATE_FROM_FILE;

    %if &DATE_FROM_FILE = &CURRENT_DATE %then %do;
        %let SUCCESS = 1;
        %put Date from file equal to current date;
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
        %put Program Successfully Ended;
        %return;
    %end; %else %do;
        %put ERROR: UNEXPECTED ERROR OCCURED;
        %abort;
    %end;
%mend;


%main();