data a1;
input ybar s2 a b;
datalines;
2.5 0.03 1 1
4.6 0.09 1 2
4.6 0.03 1 3
5.5 0.07 2 1
8.9 0.03 2 2
9.1 0.09 2 3
6.0 0.05 3 1
10.3 0.10 3 2
13.3 0.04 3 3
;

proc means data=a1;
	var ybar;
	by a b;
	output out=a2 mean=grandmean;

symbol1 v=square i=join c=black;
symbol2 v=diamond i=join c=black;
symbol3 v=plus i=join c=black;
proc gplot data=a2;
	plot grandmean*a=b/frame;
run;
