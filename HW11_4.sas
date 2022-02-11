data a1;
input x1 n y;
p = y/n;
datalines;
    2.0  500.0   72.0
    5.0  500.0  103.0
   10.0  500.0  170.0
   20.0  500.0  296.0
   25.0  500.0  406.0
   30.0  500.0  449.0
;

proc print data=a1;
var y x1 n;run;

proc sgscatter data = a1;
	plot p*x1;
run;

proc logistic data=a1;                **grouped trial form;
	model y / n = x1;run;

proc genmod data=a1 descending;***Grouped trials;
	model  x1 / n = y / dist=bin;
	output out=a2 p=pred;
run;

proc gplot data=a2; 
   plot p*x1 pred*p /overlay;
run;
