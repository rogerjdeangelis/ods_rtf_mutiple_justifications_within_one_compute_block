Ods Rtf: Mutiple justifications within one compute block

I did not think this was possible.
Note the end paragraph, \par', rtf control word is needed.

see
https://goo.gl/4SCBY9
https://communities.sas.com/t5/ODS-and-Base-Reporting/COMPUTE-BEFORE-PAGE-Center-and-Left-Alignment-Justification/m-p/421962

Craigs profile
https://communities.sas.com/t5/user/viewprofilepage/user-id/32706


INPUT
=====

 SASHELP.CLASS total obs=19   |        RULES
                              |                  Title    ==> centered
     NAME       SEX    AGE    |        Math Class         ==> left align
                              |
     Alfred      M      14    |        NAME       SEX    AGE
     Alice       F      13    |
     Barbara     F      13    |        Alfred      M      14
                              |        Alice       F      13
                              |        Barbara     F      13
                              |

WORKING CODE (all the code)
===========================

      * 'Title' will be centered and  'Math Class' will be left aligned.

      line "Title ^R/RTF'\par\ql Math Class";

OUTPUT (rtf)
============
  d:/rtf/mutiple_alignment.rtf

            Title
  Math Class

  NAME       SEX    AGE

  Alfred      M      14
  Alice       F      13
  Barbara     F      13

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

  located in script
  sashelp.class(obs=3 keep=name sex age)

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utlfkil(d:/rtf/mutiple_alignment.rtf);
title;footnote;
ods rtf file="d:/rtf/mutiple_alignment.rtf";
ods escapechar='^';
proc report data=sashelp.class(obs=3 keep=name sex age) nowd headskip;
cols name sex age;
compute before _page_ / style = {just=center font_weight=bold};
    line "Title ^R/RTF'\par\ql Math Class";
endcomp;
run;quit;
ods rtf close;

