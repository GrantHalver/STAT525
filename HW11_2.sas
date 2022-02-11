data a1;
input y index j y2;
datalines;
    7.6      1      1    8.2
    8.2      1      2    7.9
    6.8      1      3    7.0
    5.8      1      4    5.7
    6.9      1      5    7.2
    6.6      1      6    7.0
    6.3      1      7    6.5
    7.7      1      8    7.9
    6.0      1      9    6.3
    6.7      2      1    8.8
    8.1      2      2   10.0
    9.4      2      3   10.7
    8.6      2      4   10.0
    7.8      2      5    9.7
    7.7      2      6    9.4
    8.9      2      7   10.6
    7.9      2      8    9.8
    8.3      2      9   10.0
    8.7      2     10   10.3
    7.1      2     11    8.9
    8.4      2     12   10.0
    8.5      3      1   11.5
    9.7      3      2   12.2
   10.1      3      3   12.8
    7.8      3      4   11.0
    9.6      3      5   12.3
    9.5      3      6   12.1
;

proc sgplot data=a1;
	scatter y=y x=y2 / group=index;
run;

proc means noprint;
	var y2 y;
	by index;
	output out=a1m mean=xbar ybar stddev=sx sy;

proc print;
	var xbar sx ybar sy;
run;

proc glm plots=all data=a1;
	class index;
	model y = index / solution;
	lsmeans index / adjust=tukey;
	output out=a2 r=resid;
run;

proc glm plots=all data=a1;
	class index;
	model y = y2 index / solution;
	lsmeans index / adjust=tukey;
	output out=a2 r=resid;
run;

proc print data=a2; run; quit;

proc sgplot data=a2;
	scatter y=y x=resid / group=index;
run; quit;

proc univariate data = a2;
	class index;
	qqplot resid/ normal(mu=0 sigma=0.20825);
run;

proc glm plots=all data=a1;
	class index;
	model y = y2 index y2*index / solution;
	lsmeans index / adjust=tukey;
run;
