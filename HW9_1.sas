data a1;
input grade a b;
datalines;
   80    1    1    1
   80    1    2    1
   80    1    3    1
   90    2    1    1
   90    2    2    1
   90    2    3    1
;

data a2;
input grade a b;
datalines;
   75    1    1    2
   80    1    2    2
   90    1    3    2
   80    2    1    2
   86    2    2    2
   97    2    3    2
;

data a3;
input grade a b;
datalines;
   75    1    1    3
   80    1    2    3
   85    1    3    3
   75    2    1    3
   85    2    2    3
  100    2    3    3
  ;

proc means data=a1;
	var grade;
	by a b;
	output out=a4 mean=avgrade;

symbol1 v=square i=join c=black;
symbol2 v=diamond i=join c=black;
symbol3 v=plus i=join c=black;
proc gplot data=a4;
	plot avgrade*a=b/frame;
run;

proc means data=a2;
	var grade;
	by a b;
	output out=a5 mean=avgrade;

symbol1 v=square i=join c=black;
symbol2 v=diamond i=join c=black;
symbol3 v=plus i=join c=black;
proc gplot data=a5;
	plot avgrade*a=b/frame;
run;

proc means data=a3;
	var grade;
	by a b;
	output out=a6 mean=avgrade;

symbol1 v=square i=join c=black;
symbol2 v=diamond i=join c=black;
symbol3 v=plus i=join c=black;
proc gplot data=a6;
	plot avgrade*a=b/frame;
run;
