data randr;
input part operator meas;
datalines;
1  1  22
1  1  22
1  1  21
1  2  23
1  2  22
1  2  22
1  3  23
1  3  22
1  3  23
1  4  21
1  4  20
1  4  21
2  1  21
2  1  21
2  1  22
2  2  21
2  2  20
2  2  20
2  3  24
2  3  23
2  3  23
2  4  22
2  4  21
2  4  21
3  1  25
3  1  24
3  1  25
3  2  25
3  2  24
3  2  25
3  3  24
3  3  25
3  3  24
3  4  25
3  4  25
3  4  24
4  1  24
4  1  23
4  1  23
4  2  22
4  2  21
4  2  21
4  3  21
4  3  22
4  3  23
4  4  22
4  4  23
4  4  22
5  1  23
5  1  24
5  1  23
5  2  24
5  2  23
5  2  23
5  3  25
5  3  25
5  3  24
5  4  24
5  4  24
5  4  26
6  1  23
6  1  23
6  1  23
6  2  23
6  2  22
6  2  22
6  3  24
6  3  24
6  3  24
6  4  23
6  4  24
6  4  24
7  1  22
7  1  22
7  1  23
7  2  23
7  2  22
7  2  22
7  3  22
7  3  21
7  3  22
7  4  22
7  4  22
7  4  21
8  1  23
8  1  22
8  1  24
8  2  23
8  2  23
8  2  23
8  3  24
8  3  24
8  3  23
8  4  23
8  4  22
8  4  22
9  1  23
9  1  23
9  1  23
9  2  22
9  2  21
9  2  21
9  3  24
9  3  23
9  3  22
9  4  21
9  4  22
9  4  22
10  1  24
10  1  24
10  1  24
10  2  23
10  2  22
10  2  22
10  3  22
10  3  23
10  3  22
10  4  24
10  4  24
10  4  25
;

proc mixed cl data=randr;
 class operator part;
 model meas= / ddfm=kr residual;
 random part operator operator*part /vcorr;
run;

proc mixed alpha=.05 cl covtest nobound data=randr;
 class operator part;
 model meas=operator / ddfm=kr residual;
 random part operator*part;
 lsmeans operator / alpha=.05 cl diff adjust=tukey;
run;

proc means;
run; quit;
