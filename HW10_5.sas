data amalyse;
input patient method amalyse;
datalines;
1 1 350 
1 2 385 
1 3 341 
1 4 452 
2 1 1040 
2 2 1167 
2 3 1017 
2 4 1245 
3 1 632 
3 2 750 
3 3 591 
3 4 804 
4 1 1150 
4 2 1157 
4 3 1351 
4 4 1442 
5 1 532 
5 2 650 
5 3 491 
5 4 704 
6 1 463 
6 2 520 
6 3 471 
6 4 502 
7 1 1200 
7 2 1340 
7 3 1144 
7 4 1300
;

proc mixed alpha=.05 cl covtest nobound data=amalyse;
 class patient method;
 model amalyse=method / ddfm=kr residual;
 random method patient*method;
 lsmeans method / alpha=.05 cl diff adjust=tukey;
run;
