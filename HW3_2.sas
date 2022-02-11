data a1;
	input x expy;
	datalines;
	4 36
	8 40
	12 44
	16 48
	20 52
;


data sim;
 set a1;
 do sim=1 to 10000;
  y = 20 + 4*x +normal(612)*sqrt(25);
  output;
 end;
run;

proc sort data=sim; by sim; run;

proc reg data=sim;
 model y = x;
 by sim;
 ods output ParameterEstimates=bc;
run;

***The following turns it back on;
ods graphics on;
ods exclude none;
ods results on;
options notes;

data simresults;
 set bc;
 if Variable="x";
 Reject=0;
 if Probt < 0.05 then Reject=1;
run;

proc means; var Reject; run;

proc print data=bc (obs = 20);
run;

proc univariate data=bc;
	var Estimate;
	histogram;
run;

data classSimple;
set bc;
orig_obs = _n_;
if mod(_n_,2) eq 0 then output;
run;

proc print data=classSimple(obs=10);
run;

proc univariate data=classSimple;
	var Estimate;
	histogram;
run;

data classSimple1;
set bc;
orig_obs = _n_;
if mod(_n_,2) eq 1 then output;
run;

proc univariate data=classSimple1;
	histogram Estimate;
run;
