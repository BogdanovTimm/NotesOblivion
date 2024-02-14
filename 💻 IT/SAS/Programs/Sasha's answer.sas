%let DWL_TODAY = %sysget(DWL_TODAY);

%macro mPdftCheck;
            %if "&DWL_TODAY" = "" %then %do;
                %put ERROR: Parameter DWL_TODAY not defined.;
                %abort;
            %end;

            %let DWL_TODAY=%sysfunc(inputn(&DWL_TODAY, DDMMYY10.));

            %let warte_mich = 1;
            %let i = 1;

      %do %while (&warte_mich = 1) ;
            %let i=%eval(&i + 1);

            filename PdftDate "/sas/dwh/mr&DWL_MR./logs/automation/pdft/pdft.dwl_today";
            data _null_;
                infile PdftDate;
                input Date $ 1-10;
                call symput ('PdftLoadDate', Date);
            run;


            %let PdftLoadDate=%sysfunc(inputn(&PdftLoadDate, DDMMYY10.));
            %put &PdftLoadDate;
            %put &DWL_TODAY;

            %if "&PdftLoadDate" = "" %then %do;
                  %put ERROR: Pdft transport does not loaded. Please check /sas/dwh/mr&DWL_MR./logs/automation/pdft/pdft.dwl_today;
                  abort;
            %end;

            /*  ¶ФРвм 18 аРЧ ЯЮ 10 ЬШЭгв. (3 зРбР)  sleep  ЭШЦХ    asmyasni@mts.ru*/
            %if &i > 18 or &PdftLoadDate >= &DWL_TODAY %then %do;
                %let warte_mich = 0;
            %end;

            %if &PdftLoadDate < &DWL_TODAY %then %do;
                  %if &warte_mich = 0 %then %do;
                      %put ERROR: Requested DWL_TODAY date is greater then PDFT.DWL_TODAY;
                      %abort;
                  %end;
                  %else %do;
                      /* ¶ФРвм 10 ЬШЭгв    asmyasni@mts.ru*/
                      data _null_;
                        a=sleep(600,1);
                      run;
                  %end;
            %end;
      %end;

%mend;

%let DWL_TODAY = %sysget(DWL_TODAY);
%put &DWL_TODAY;

%mPdftCheck;
