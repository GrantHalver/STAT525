data a1;
input y x1 x2;
datalines;
   28.0      1      1
   26.0      1      2
   31.0      1      3
   27.0      1      4
   35.0      1      5
   34.0      2      1
   29.0      2      2
   25.0      2      3
   31.0      2      4
   29.0      2      5
   31.0      3      1
   25.0      3      2
   27.0      3      3
   29.0      3      4
   28.0      3      5
;

symbol1 v=circle i=none;
proc gplot data = a1;
	plot y*x1;
run;

proc means data=a1;
	var cases; by design;
	output out=a2 mean=avcases;
proc print data=a2;

symbol1 v=circle i=join;
proc gplot data=a2;        
	plot avcases*design;
run;

proc glm data=a1;
	class x1;
	model y=x1;
	means x1;
	lsmeans x1 / stderr;
run;

proc mixed data=a1;
	class x1;
	model y=x1;
	lsmeans x1;
run;

data a2;
input y x1 x2;
datalines;
   -1.4      1      1
   -3.4      1      2
   1.6      1      3
   -2.4      1      4
   5.6      1      5
   4.4      2      1
   -0.6      2      2
   -4.6      2      3
   1.6      2      4
   -0.5      2      5
   3      3      1
   -3      3      2
   -1      3      3
   -1      3      4
    0     3      5
;

proc univariate data = a2;
  qqplot y/ normal(mu=0 sigma=2.88713072);
run;
