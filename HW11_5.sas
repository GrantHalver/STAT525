data a1;
input symptoms econ life;
datalines;
1 1 1
1 1 9
1 1 4
1 1 3
1 0 2
1 1 0
1 0 1
1 1 3
1 1 3
1 1 7
1 0 1
1 0 2
2 1 5
2 0 6
2 1 3
2 0 1
2 1 8
2 1 2
2 0 5
2 1 5
2 1 9
2 0 3
2 1 3
2 1 1
3 0 0
3 1 4
3 0 3
3 0 9
3 1 6
3 0 4
3 0 3
4 1 8
4 1 2
4 1 7
4 0 5
4 0 4
4 0 4
4 1 8
4 0 8
4 0 9
;

proc logistic order=data data = a1;
	class symptoms econ;    ***key difference;
	model symptoms = life;
	output out=a2 predprobs=I;
run;

proc logistic order=data data = a1 descending plots=all;
	class symptoms econ;    ***key difference;
	model symptoms = econ life;
	output out=a2 predprobs=I;
run;

proc print data = a2; run;

proc gplot data=a2; 
   plot symptoms*life=econ predprobs*life=econ /overlay;
run;
