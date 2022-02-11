data a1;
input earn a b n;
datalines;
    1.7      1      1      1
    1.9      1      1      2
    1.8      1      2      1
    2.1      1      2      2
    2.5      1      3      1
    2.7      1      3      2
    2.9      1      3      3
    2.5      1      3      4
    2.6      1      3      5
    2.8      1      3      6
    2.7      1      3      7
    2.9      1      3      8
    2.5      2      1      1
    2.3      2      1      2
    2.6      2      1      3
    2.4      2      1      4
    2.7      2      2      1
    2.4      2      2      2
    2.6      2      2      3
    2.4      2      2      4
    2.5      2      2      5
    3.5      2      3      1
    3.3      2      3      2
    3.6      2      3      3
    3.4      2      3      4
    2.7      3      1      1
    2.8      3      1      2
    2.9      3      2      1
    3.0      3      2      2
    2.8      3      2      3
    2.7      3      2      4
    3.7      3      3      1
    3.6      3      3      2
    3.7      3      3      3
    3.8      3      3      4
    3.9      3      3      5
    2.5      4      1      1
    2.6      4      1      2
    2.3      4      2      1
    2.8      4      2      2
    3.3      4      3      1
    3.4      4      3      2
    3.3      4      3      3
    3.5      4      3      4
    3.6      4      3      5
;

proc print data=a1; run;
data a1; set a1;
   if (a eq 1)*(b eq 1) then gb='1_HB';
   if (a eq 1)*(b eq 2) then gb='2_HM';
   if (a eq 1)*(b eq 3) then gb='3_HP';
   if (a eq 2)*(b eq 1) then gb='4_SB';
   if (a eq 2)*(b eq 2) then gb='5_SM';
   if (a eq 2)*(b eq 3) then gb='6_SP';
   if (a eq 3)*(b eq 1) then gb='7_EB';
   if (a eq 3)*(b eq 2) then gb='8_EM';
   if (a eq 3)*(b eq 3) then gb='9_EP';
   if (a eq 4)*(b eq 1) then gb='10_BB';
   if (a eq 4)*(b eq 2) then gb='11_BM';
   if (a eq 4)*(b eq 3) then gb='12_BP';
run;
title1 'Plot of the data';
symbol1 v=circle i=none c=black;
proc gplot data=a1; 
   plot earn*gb/frame;
run;
proc means data=a1; 
   output out=a2 mean=avearn;
   by a b;
title1 'Plot of the means';
symbol1 v='H' i=join c=black;
symbol2 v='S' i=join c=black;
symbol3 v='E' i=join c=black;
symbol4 v='B' i=join c=black;
proc gplot data=a2; 
   plot avearn*b=a/frame;
run;

proc glm data=a1; 
   class a b;
   model earn=a|b/solution;
   means a*b;
   contrast 'a Type III' 
     a 3 -3 
     a*b 1 1 1 -1 -1 -1;
   estimate 'a Type III' 
     a 3 -3 
     a*b 1 1 1 -1 -1 -1;
   contrast 'a Type I' 
     a 7 -7 
     b 2 -1 -1
     sex*b 3 2 2 -1 -3 -3;
   estimate 'a Type I' 
     a 7 -7 
     b 2 -1 -1
     a*b 3 2 2 -1 -3 -3;
   contrast 'b Type III' 
     b 2 -2 0
     a*b 1 -1 0 1 -1 0,
     b 0 2 -2
     a*b 0 1 -1 0 1 -1;
   contrast 'a*b Type I and III' 
     a*b 1 -1 0 -1 1 0,
     a*b 0 1 -1 0 -1 1;
run;

proc glm data=a1; 
   class a b;
   model earn=a|b;
   means a b/ tukey lines;
   lsmeans a b / adjust=tukey lines pdiff;

proc glm data=a1; 
   class a b;
   model earn=a b;
   means a b/ tukey lines;
   lsmeans a b / adjust=tukey lines pdiff;
run;
quit;
