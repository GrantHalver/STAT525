data sales;
	input y x;
	sqrty = sqrt(y);
	datalines;
	   98.0    0.0
	  135.0    1.0
	  162.0    2.0
	  178.0    3.0
	  221.0    4.0
	  232.0    5.0
	  283.0    6.0
	  300.0    7.0
	  374.0    8.0
	  395.0    9.0
 ;

proc gplot data = sales;
 	plot y*x;
run;

proc transreg data = sales;
	model  boxcox(y)=identity(x);
run;

proc gplot data = sales;
	plot sqrty*x;
run;

proc reg data = sales;
	model sqrty=x;
run;
