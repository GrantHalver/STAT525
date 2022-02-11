data plastic;
	input hardness time;
	t2 = time - 28;
	t22 = t2*t2;
	datalines;
	  199.0   16.0
  205.0   16.0
  196.0   16.0
  200.0   16.0
  218.0   24.0
  220.0   24.0
  215.0   24.0
  223.0   24.0
  237.0   32.0
  234.0   32.0
  235.0   32.0
  230.0   32.0
  250.0   40.0
  248.0   40.0
  253.0   40.0
  246.0   40.0
  ;

proc reg data=plastic;
  	model hardness=time/clb p r;
	output out=a2 p=pred r=resid;
	id time;
run;

proc gplot data=a2;
	plot resid*time/vref=0;
	where hardness ne .;
run;

proc means data=plastic;
run;

proc print data = plastic;
sum t22;
run; 
