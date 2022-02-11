data typo;
input y x;
datalines;
  128.0    7.0
  213.0   12.0
  191.0   10.0
  178.0   10.0
  250.0   14.0
  446.0   25.0
  540.0   30.0
  457.0   25.0
  324.0   18.0
  177.0   10.0
   75.0    4.0
  107.0    6.0
;

proc reg data = typo;
	model y=x/ NOINT;
	output out=a2 r=resid;
run;

proc gplot data = a2;
	plot resid*x/vref=0;
run;

proc reg data = typo;
	model y=x;
run;
