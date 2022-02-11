data blood;
input y x;
datalines;
   63.0    5.0
   67.0    8.0
   74.0   11.0
   64.0    7.0
   75.0   13.0
   69.0   12.0
   90.0   12.0
   60.0    6.0
;

proc reg data=blood;
	model y=x;
	output out=a2 r=resid;
run;

proc gplot data=a2;
	plot resid*x;
run;

data blood1;
input y x;
datalines;
   63.0    5.0
   67.0    8.0
   74.0   11.0
   64.0    7.0
   75.0   13.0
   69.0   12.0
   60.0    6.0
;

proc reg data=blood1;
	model y=x;
	output out=a2 r=resid;
run;

proc gplot data=a2;
	plot resid*x;
run;

proc means data=a2;
run;

(12-8.8571429)^2/summation(xi-8.8571429)^2
