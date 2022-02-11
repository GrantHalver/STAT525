data reaction;
input concentration velocity;
cinv = 1/concentration;
vinv = 1/velocity;
datalines;
0.02 76
0.02 47
0.06 97
0.06 107
0.11 123
0.11 139
0.22 159
0.22 152
0.56 191
0.56 201
1.10 207
1.10 200
;

proc gplot data = reaction;
	plot Velocity*Concentration;
	plot vinv*cinv;
run;

proc univariate data = reaction;
	histogram concentration / normal kernel(L=2);
	histogram cinv / normal kernel(L=2);
	qqplot concentration / normal (L=1 mu=est sigma=est);
	qqplot cinv / normal (L=1 mu=est sigma=est);
run;

proc reg data = reaction;
	model vinv = cinv;
	output out=a2 p=pred r=resid;
run;

proc gplot data = a2;
	plot resid*cinv/vref = 0;
run;

DATA a2;
set a2;
predinv = 1/pred;
run;

proc gplot data = a2;
	plot predinv*concentration;
run;

symbol1 interpol=rcclm95
       value=circle
       cv=darkred
       ci=black
       width=2;

plot velocity*concentration;

run;
quit;
