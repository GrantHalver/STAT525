data a1;
input y x1 x2 x3;
datalines;
  48    50    51   2.3
  57    36    46   2.3
  66    40    48   2.2
  70    41    44   1.8
  89    28    43   1.8
  36    49    54   2.9
  46    42    50   2.2
  54    45    48   2.4
  26    52    62   2.9
  77    29    50   2.1
  89    29    48   2.4
  67    43    53   2.4
  47    38    55   2.2
  51    34    51   2.3
  57    53    54   2.2
  66    36    49   2.0
  79    33    56   2.5
  88    29    46   1.9
  60    33    49   2.1
  49    55    51   2.4
  77    29    52   2.3
  52    44    58   2.9
  60    43    50   2.3
  86    23    41   1.8
  43    47    53   2.5
  34    55    54   2.5
  63    25    49   2.0
  72    32    46   2.6
  57    32    52   2.4
  55    42    51   2.7
  59    33    42   2.0
  83    36    49   1.8
  76    31    47   2.0
  47    40    48   2.2
  36    53    57   2.8
  80    34    49   2.2
  82    29    48   2.5
  64    30    51   2.4
  37    47    60   2.4
  42    47    50   2.6
  66    43    53   2.3
  83    22    51   2.0
  37    44    51   2.6
  68    45    51   2.2
  59    37    53   2.1
  92    28    46   1.8
  ;

proc reg data=a1;
	model y=x1 x2 x3 / r partial influence tol;
	id x1 x2 x3;
	plot r.*(p. x1 x2 x3);

proc reg data=a1;
	model y x1 = x2 x3;
	output out=a2 r=resins resris;

proc sort data=a2; by resris;
proc gplot data=a2;
	plot resins*resris;
run;

proc reg data=a2;
	model resins = resris;
	output out=new1 r=res p=pred;
run;

proc reg data=a1;
	model y x2 = x1 x3;
	output out=a2 r=resins resris;

proc sort data=a2; by resris;
proc gplot data=a2;
	plot resins*resris;
run;

proc reg data=a2;
	model resins = resris;
	output out=new1 r=res p=pred;
run;

proc reg data=a1;
	model y x3 = x1 x2;
	output out=a2 r=resins resris;

proc sort data=a2; by resris;
proc gplot data=a2;
	plot resins*resris;
run;

proc reg data=a2;
	model resins = resris;
	output out=new1 r=res p=pred;
run;
