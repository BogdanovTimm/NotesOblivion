#              Find length of a text

`LENGTHN()` - counts number of characters (white spaces are not counted)

```SAS
DATA output_table; 
    SET database_name.table_name; 
    IF LENGTHN(text_column) > 12; 

RUN; 
```










#              Change case

```SAS
DATA output_table; 
    SET database_name.table_name; 
    uppercase_column = UPCASE(text_column); 
	lowercase_column = LOWCASE(text_column); 
	first_letter_big_next_small_column = PROPCASE(text_column); 
RUN; 
```










#             Remove whitespaces

```SAS
DATA output_table; 
    text_column = '          [     [Lorem]     ]          ';
	remove_trailing_spaces_from_left = LEFT(text_column);
	remove_trailing_spaces_from_right = TRIM(text_column);
	remove_all_trailing_spaces = STRIP(text_column);
    remove_all_repeated_spaces = COMPBL(text_column);
RUN;
```










#              Remove all occurence of some characters

Modifiers for `COMPRESS('original text', 'characters to delete', 'daispk')` (modifiers are last argument):
- `d` - Adds numerals (digits) to the list of characters to be deleted 
- `a` - Adds upper- and lowercase letters to the list of characters to be deleted 
- `i` - Ignores case 
- `s` - Adds blanks, tabs, line-feeds, or carriage returns to the list of characters to be deleted 
- `p` - Adds punctuation to the list of characters to be deleted
- `k` - Keeps listed characters instead of removing them 

Text to delete, like 'ABC' doesn't deletes each 'ABC' - it deletes each 'A', 'B' and 'C'.

```SAS
DATA output_table; 
    LENGTH phones_column $ 10; 
    SET database_name.table_name; 
        phones_new_column = COMPRESS(8 (911) 377-17-47, ' ()-.');
        DROP phones_original_column; 
RUN;
```










#                 Find text

Returns position of a given text (it works like `*given text*` in regexp)

```SAS
DATA output_table;
	text_old_column = 'Hello! HELLO! hElLo! 56 ';
	IF FIND(text_old_column, 'hElLo', 'i', 3) THEN DO; /* last integer indicates starting position for search */
	    new_column = 'there is a hello there';
	END;
RUN;
```










#                 Find characters

Returns position of a given text (it works like `*(g|i|v|e|n| |t|e|x|t)*` in regexp)

```SAS
DATA output_table;
	text_old_column = 'Hello! HELLO! hElLo! 56 ';
	IF FINDC(text_old_column, 'hElLo', 'i', 3) THEN DO; /* last integer indicates starting position for search */
	    new_column = 'there is a hello there';
	END;
RUN;
```










#                 Find words

Finds only text that is between 2 delimeters (it works like `(|delimeter)given text(delimeter|)`)

```SAS
DATA output_table;
	text_old_column = 'dog:Cat! 56 ';
          /* original text  , text to find, delimeter */
	IF FINDW(text_old_column, 'dog'       , ':'       ) THEN DO; /* last integer indicates starting position for search */
	    new_column = 'there is a [dog] here between delimeter [:]';
	END;
RUN;
```










#                 Find classes of characters

All these functions return the position of a first finded character of a given class.

```SAS
DATA output_table;
    text_column = 'Lorem 1 2 !! Ipsum';
             /* given text , offset */
    IF ANYDIGIT(text_column, 3) THEN DO;
        digit = 'There is a digit';
	END;
	IF ANYALPHA(text_column, 4) THEN DO;
        letters = 'There is a letter';
	END;
	IF ANYALNUM(text_column, 2) THEN DO;
        letters_or_numbers = 'There is a letter OR a digit';
	END;
	IF ANYPUNCT(text_column, 6) THEN DO;
        special_characters = 'There is a special character';
	END;
	IF ANYSPACE(text_column, 7) THEN DO;
        space = 'There is a space';
	END;
RUN;
```










##                Find first non-class

These functions return the position of a first finded character that does not belong to a given class:

```SAs
DATA output_table;
    text_column = 'Lorem 1 2 !! Ipsum';
    IF NOTDIGIT(TRIM(text_column)) THEN DO;
        digit = 'There is something except the digits';
	END;
	IF NOTALPHA(TRIM(text_column)) THEN DO;
        letters = 'There is something excpet the letters';
	END;
	IF NOTALNUM(TRIM(text_column)) THEN DO;
        letters_or_numbers = 'There is something except letters or digits';
	END;
RUN;
```










#                Find frist non-given text

This function returns first occurance of a non-given character

```Sas
DATA output_table; 
    INPUT
       text_column : $5.
    ;
    IF VERIFY(text_column,'ABCDE') THEN DO;
		validation_column  = 'There is something else! Error!'; 
	END; ELSE DO;
        validation_column = 'There are only given characters';
	END;
DATALINES; 
AABDE
A-BBD
12345
;
```










#                 Substring text

```SAS
DATA output_table;
    LENGTH /*It is important to choose length here, otherwise it will be equal to the length of a [text_column]*/
        give_or_gift $4
        amount        3
    ;
    text_column = 'I will give you 100 dollars';
	                /* original text , starting position, length */
    give_or_gift = SUBSTR(text_column, 8                , 4     ); 
    amount = INPUT(SUBSTR(text_column, 17               , 3     ), 3.); 
RUN;
```









##                Find Xth words

```SAS
DATA output_table;
    original_text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
    LENGTH
        second_word_from_start $ 15
        second_word_from_end  $ 15
    ;
	                           /* original text, number of a word, delimeter */
    second_word_from_start = SCAN(original_text, 3               , ' '      ); 
    second_word_from_end   = SCAN(original_text, -2              , ' '      ); 
RUN;
```








##                Check whether identical

`COMPARE()` checks whether 2 strings are identical.

```SAS
DATA output_table; 
    INPUT text_column $10.;
            /* original text, text to compare, modifiers */
    IF COMPARE(text_column  , 'V450'         , 'i'      ) = 0 THEN DO;
        whether_identical_column = 'Yes'; 
	END; ELSE DO;
        whether_identical_column = 'No'; 
	END;
DATALINES; 
V450
v450
v450.100
V900
;
```






##                Fuzzy find

```SAS
DATA fuzzy; 
    INPUT
        text_column $20.
    ; 
    find_score = SPEDIS(text_column, 'Friedman'); 

DATALINES; 
Friedman
Freedman
Xriedman
Freidman
Friedmann
Alfred
FRIEDMAN
;
```







# Replace each occurance of a character

```SAS
DATA output_table; 
    original_text = 'Lorem Ipsum';
    modified_text = TRANSLATE(original_text, '27', 'mp'); 
RUN;
```









# Replace every occurance of a given word

```SAS
DATA output_table; 
    INFILE DATALINES DELIMITER = ' ,'; /* Blanks or commas are delimiters */
    INPUT 
        #1 line1         $30. /* #1 means 1st line (or X+1th line) */
        #2 line2         $40. 
        #3 line3_city  & $20. /* [&] means that it goes to another row or column where it finds 2 or more whitespaces*/
           line3_state : $2.  /* [:] means that it goes to another row or column where it finds 1 whitespace*/
           line3_zip   : $5.
    ; 
    line1 = TRANWRD(line1,'Mr.',' '); 
    line1 = TRANWRD(line1,'Mrs.',' '); 
    line1 = TRANWRD(line1,'Dr.',' '); 
    line1 = TRANWRD(line1,'Ms.',' '); 
    line1 = LEFT(line1); 
    line2 = TRANWRD(line2, 'Street', 'St.' ); 
    line2 = TRANWRD(line2, 'Road'  , 'Rd.' ); 
    line2 = TRANWRD(line2, 'Avenue', 'Ave.'); 
DATALINES; 
Dr. Peter Benchley 
123 River Road 
Oceanside, NY 11518 
Mr. Robert Merrill 
878 Ocean Avenue 
Long Beach, CA 90818 
Mrs. Laura Smith 
80 Lazy Brook Road 
Flemington, NJ 08822 
; 
```








#                 Join Stings

```SAS
DATA output_table; 
    Length
        with_original_whitespaces_old
        with_original_whitespaces 
        without_whitespaces 
		with_1_whitespace $ 15;
    text1 = 'Ron      ';
    text2 = 'Cody';
    with_original_whitespaces_old = text1 || text2; 
    with_original_whitespaces = CAT(text1, text2); 
    without_whitespaces = CATS(text1, text2); 
    with_1_whitespace = CATX(' ', text1, text2); 
RUN;
```