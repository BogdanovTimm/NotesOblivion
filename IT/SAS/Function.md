#                    Call

Use `CALL FUNCTION_NAME()` if you need to return more than a single value.










#                  Create a new one

Do not put `;` after functions!

```SAS
%macro new_function(argument1, argument2, argument3);
    data function_output;
        do iterator = 1 to &argument1;
            random_number = int((&argument3 - &argument2 +1) * ranuni(0) +&argument2);
            output;
        end;
    run;

    proc print data = function_output;
    run;
%mend new_function;

%new_function(4, 1, 100) /* Do not put [;] after functions!!! */
```










#                  Logic if global variables is used

```SAS
%macro new_function;
                %if "&ENVIRONMENTAL_VARIABLE" = "" %then %do;
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
```