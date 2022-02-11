data brand;
input y x1 x2;
datalines;
   64.0    4.0    2.0
   73.0    4.0    4.0
   61.0    4.0    2.0
   76.0    4.0    4.0
   72.0    6.0    2.0
   80.0    6.0    4.0
   71.0    6.0    2.0
   83.0    6.0    4.0
   83.0    8.0    2.0
   89.0    8.0    4.0
   86.0    8.0    2.0
   93.0    8.0    4.0
   88.0   10.0    2.0
   95.0   10.0    4.0
   94.0   10.0    2.0
  100.0   10.0    4.0
  ;

proc reg data = brand;
	model y = x1 x2;
run;

proc reg data = brand;
	model x1 = x2;
	output out=a2 r=resid;
run;

proc print data = a2;
run;

proc scatter data = a2;
	plot resid*x1;
run;

proc reg data = brand;
	model y = x2;
	output out=a3 r=resid;
run;

proc print data = a3;
run;

data resids;
input r1 r2;
datalines;
-3 -13.375 
-3 -13.125 
-3 -16.375 
-3 -10.125 
-1 -5.375 
-1 -6.125 
-1 -6.375 
-1 -3.125 
1 5.625 
1 2.875 
1 8.625 
1 6.875 
3 10.625 
3 8.875 
3 16.625 
3 13.875
;

proc reg data = resids;
	model r2 = r1;
run;

proc reg data = brand;
	model y = x2;
run;

proc reg data = brand;
	model y = x1 x2;
run;
quit;
