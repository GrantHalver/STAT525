data a1;
input y x1;
datalines;
   77.0   16.0
   70.0   14.0
   85.0   22.0
   50.0   10.0
   62.0   14.0
   70.0   17.0
   55.0   10.0
   63.0   13.0
   88.0   19.0
   57.0   12.0
   81.0   18.0
   51.0   11.0
;

proc reg data=a1;
	model y = x1;
	output out = a2 r = resid;
run;

data a2;
	set a2;
	absresid = abs(resid);

proc sgscatter data = a2;
	plot absresid*x1;
run;

proc reg data = a2;
	model absresid = x1;
run;

data a2;
	set a2;
	s_hat = -0.90486+0.32263*X1;
	wi = 1/(s_hat*s_hat);

proc print data = a2;
	var wi;
run;
quit;

proc reg data = a2;
	model y = x1/ clb;
	weight wi;
	output out = a3 r=resid1;
run;

data a3;
	set a3;
	absresid1 = abs(resid1);

proc reg data = a3;
	model absresid1 = x1;
run;

data a3;
	set a3;
	s_hat = -0.90486+0.32263*X1;
	wi1 = 1/(s_hat*s_hat);

proc reg data = a3;
	model y = x1/ clb;
	weight wi1;
run;

data a2;
	set a2;
	sqwi = sqrt(wi);
	sqwiy = y*sqwi;
	sqwix = sqwi*x1;

proc reg data = a2;
	model sqwiy = sqwix/ clb;
	output out=a4 r=sqwie;
run;

proc reg data = a2;
	model y = x1/ clb;
	weight wi;
run;

data a4;
	set a4;
	sqwie1 = sqwi*resid;

proc print data=a4;
	var y sqwiy x1 sqwix sqwie sqwie1 resid sqwi wi;
run;
