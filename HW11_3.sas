data a1;
input y x;
datalines;
    0.0  474.0
    0.0  432.0
    0.0  453.0
    1.0  481.0
    1.0  619.0
    0.0  584.0
    0.0  399.0
    1.0  582.0
    1.0  638.0
    1.0  624.0
    1.0  542.0
    1.0  650.0
    1.0  553.0
    0.0  425.0
    1.0  563.0
    0.0  549.0
    1.0  498.0
    0.0  520.0
    1.0  610.0
    0.0  598.0
    0.0  491.0
    0.0  617.0
    1.0  621.0
    0.0  573.0
    1.0  562.0
    0.0  506.0
    1.0  600.0
;

symbol1 v=circle i=sm70;
proc gplot data=a1;
 plot y*x;
run;

proc sort data=a1; by y;
proc freq data=a1;
 tables x / out=a1c;
 by y;

data y0;
 set a1c; if y=0;
 x0=count; drop count;

data y1;
 set a1c; if y=1;
 x1=count; drop count;
run;

data a1c;
 merge y0 y1;
 by x; 
 if x0=. then x0=0;
 if x1=. then x1=0;
 n=x0 + x1;
run;

proc print data=a1c; 
 var x x1 n;
run;

proc logistic data=a1 descending; 
   model y = x; 
   output out=a2 p=pred;
run;

proc print;
run;

symbol1 v=circle i=sm70;
symbol2 v=star i=sm50;
proc gplot data=a2; 
   plot y*x pred*x /overlay;
run;

proc logistic data=a1c; 
   model x1 / n = x; 
run;

proc genmod data=a1 descending; 
   model y = x / dist=bin aggregate=increase; 
run;

proc genmod data=a1 descending; 
   model y = x / dist=bin; 
run;

proc genmod data=a1c descending; 
   model  x1 / n = x / dist=bin; 
run;

proc glimmix data=a1; 
   model y(descending) = x / chisq solution dist=binary; 
run;

proc glimmix data=a1c; 
   model x1/ n = x / chisq solution dist=binomial; 
run;


proc sort data=a1; by increase;

proc logistic data=a1 plots=all descending; 
   model y = x / lackfit; 
   output out=a2 p=pred;
run;

**Computing quantile residuals for logistic regression; 
data a3;
 set a2;
 u = ranuni(610);
 q = (1-renew)*u*(1-pred) + renew*(1-pred + u*pred);
 z = quantile('normal',q,0,1);
 run;

 proc sgplot;
  scatter x=increase y=z;
  refline 0 / axis=y;
 run;

data a3;
 set a2;
 u = ranuni(611);
 q = (1-renew)*u*(1-pred) + renew*(1-pred + u*pred);
 z = quantile('normal',q,0,1);
 run;

 proc sgplot;
  scatter x=increase y=z;
  refline 0 / axis=y;
 run;

data a3;
 set a2;
 u = ranuni(612);
 q = (1-renew)*u*(1-pred) + renew*(1-pred + u*pred);
 z = quantile('normal',q,0,1);
 run;

 proc sgplot;
  scatter x=increase y=z;
  refline 0 / axis=y;
 run;
