data a1;
input y x;
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
	model y = x;
	output out = a2 r = resid;
run;

data a2;
	set a2;
	absr = abs(resid);

proc reg data=a2;
	model absr=x;
	output out=a3 p=shat;

data a3;
	set a3;
	wt=1/(shat*shat);
	wty = sqrt(wt)*y;
	wtx = sqrt(wt)*x;

proc reg data = a3;
	model wty = wtx;
	output out=a4 p=pred;
run;

data a4;
	set a4;
	normpred = pred/sqrt(wt);

proc reg data = a4;
	model y=x / clb;
	weight wt;
	output out=a5 p=pred1;
run;

proc print data = a5;
run;
