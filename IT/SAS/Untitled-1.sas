%let DWL_TODAY = '24JAN2024'd; /* Because there is no DWL_TODAY */

%macro mPdftCheck;
                %if "&DWL_TODAY" = "" %then %do;
                    %put ERROR: Parameter DWL_TODAY not defined.;
                    %abort;
                %end;

                filename PdftDate "/sas/dwh/mr&DWL_MR./logs/automation/pdft/pdft.dwl_today"; /* Change this variable */
                
                data _null_;
                    infile PdftDate;
                    input Date $ 1-10;
                    call symput ('PdftLoadDate', Date);
                run;


                %let PdftLoadDate=%sysfunc(inputn(&PdftLoadDate, DDMMYY10.));
                %let DWL_TODAY=%sysfunc(inputn(&DWL_TODAY, DDMMYY10.));
                %put &PdftLoadDate;
                %put &DWL_TODAY;

                %if "&PdftLoadDate" = "" %then %do;
                        %put ERROR: Pdft transport does not loaded. Please check /sas/dwh/mr&DWL_MR./logs/automation/pdft/pdft.dwl_today;
                        abort;
                %end;

                %if &PdftLoadDate < &DWL_TODAY %then %do;
                        %put ERROR: Requested DWL_TODAY date is greater then PDFT.DWL_TODAY;
                        %abort;
                %end;

%mend;

%let DWL_TODAY = '24JAN2024'd;
%put &DWL_TODAY;

%mPdftCheck;