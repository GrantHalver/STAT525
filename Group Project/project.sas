**Data imported from .csv file;
data _null_;
   infile 'C:\\Users\\Grant\\Documents\\STAT525\\biles.csv' dsd truncover ;
   file 'C:\\Users\\Grant\\Documents\\STAT525\\to_sas.csv' dsd ;
   length word $200 ;
   do i=1 to 16;
      input word @;
      if word='NA' then word=' ';
	  if word='>1700' then word='1700';
	  if word='>1300' then word='1300';
	  if word='<80' then word='80';
	  if word='<200' then word='200';
      put word @;
   end;
   put;
run;

**Full data set;
proc import datafile="C:\\Users\\Grant\\Documents\\STAT525\\to_sas.csv"
        out=a1
        dbms=csv
        replace;
run;
quit;

**Confirming which variables to keep;
proc sgscatter data=a1 (where=(DX_bl eq 1));
	matrix MMSE AGE PTEDUCAT ABETA TAU Ventricles Hippocampus WholeBrain ICV CA CDCA;
run;
**Age, ICV, CA, CDCA excluded at this step;

**Box-Cox Plot to confirm transformation;
proc transreg data=a1 (where=(DX_bl eq 1));
	model boxcox(MMSE/ lambda=-1 to 5 by 0.5) = identity(PTEDUCAT)identity(ABETA) identity(TAU)
	identity(Ventricles)identity(Hippocampus) identity(WholeBrain);
run;
**Cube transform suggested;

data a1 (where=(DX_bl eq 1));
	set a1 (where=(DX_bl eq 1));
	MMSE3 = MMSE * MMSE * MMSE;
run;

proc glmselect data=a1 (where=(DX_bl eq 1));    **using FORWARD selection to fit model due to missing cases;
	class PTGENDER PTRACCAT PTETHCAT;
	model MMSE3 = PTGENDER PTEDUCAT PTRACCAT PTETHCAT ABETA TAU Ventricles Hippocampus WholeBrain/selection= FORWARD;
run;
**ABETA and Hippocampus selected;
**F=9.08, df1=2, df2=161, p-value=0.0002;
**Adj R^2 = 0.0902;

**Checking partial regression plots to see if transforming x vars will give better fit;
proc reg data=a1 (where=(DX_bl eq 1));
model MMSE3=ABETA Hippocampus / r partial influence tol;
id ABETA Hippocampus; plot r.*(p. ABETA Hippocampus);
run;
**No transform of x vars suggested;
**MMSE3 = 6310.5 + 3.4871*ABETA + 0.7532*Hippocampus;
**New line due to difference in obs used?;

**Reduced training data set for regression;
proc import datafile="C:\\Users\\Grant\\Documents\\STAT525\\to_sas.csv"
        out=a2
        dbms=csv
        replace;
run;
quit;

data a2;
	set a2 (where=(DX_bl eq 1));
	If RID >= 5029 then Delete;
	MMSE3 = MMSE * MMSE * MMSE;

**Reduced data set for validation;
**30 complete cases;
proc import datafile="C:\\Users\\Grant\\Documents\\STAT525\\to_sas.csv"
    out=a3
    dbms=csv
    replace;
run;
quit;

data a3;
	set a3 (where=(DX_bl eq 1));
	If RID < 5029 then Delete;
	MMSE3 = MMSE * MMSE * MMSE;
run; quit;

**Checking for influential points using training data set;
proc reg data=a2 (where=(DX_bl eq 1)) plots(only) = (CooksD(label) DFFits(label));   
   model MMSE3=ABETA Hippocampus;
   output out=RegOut pred=Pred rstudent=RStudent dffits=DFFits cookd=CooksD;
run; quit;
**271 most influential per Cook's D and DFFITS;
**MMSE3 = 6087.09191 + 3.80813*ABETA + 0.73283*Hippocampus;

**Find RID so only inf points get deleted later;
proc print data = RegOut;
	where CooksD > 0.15;
run;

**If 45 is deleted;
data a4;
	set a2;
	If RID = 4997 then Delete;

proc reg data=a4 (where=(DX_bl eq 1));   
   model MMSE3=ABETA Hippocampus;
run; quit;
**MMSE = 5068.02415 + 4.08788*ABETA + 0.88847*Hippocampus;

data a3;
	set a3;
	predres = MMSE3-(6087.09191 + 3.80813*ABETA + 0.73283*Hippocampus);
	deletepredres = MMSE3-(5068.02415 + 4.08788*ABETA + 0.88847*Hippocampus);
	changeresid = abs(deletepredres-predres)/predres*100;

proc means data = a3;
 	var changeresid;
run; quit;
**Within 1% so no change is needed;
**5% is threshold;

**Linear classifier?;
proc import datafile="C:\\Users\\Grant\\Documents\\STAT525\\to_sas.csv"
        out=a6
        dbms=csv
        replace;
run;
quit;

data a6;
	set a6;
	MMSE3 = MMSE * MMSE * MMSE;
	length color $8.;
	if DX_bl = 1 then color = "purple";
	if DX_bl = 2 then color = "blue";
	if DX_bl = 3 then color = "green";
	if DX_bl = 4 then color = "yellow";
	if DX_bl = 5 then color = "orange";
run;


proc sgplot data=a6;
	scatter x=ABETA y=MMSE3 / colorresponse=DX_bl;
run;

proc sgplot data=a6;
	scatter x=Hippocampus y=MMSE3 / colorresponse=DX_bl;
run;
**Neither var is sufficient on their own;

proc sgplot data=a6;
	scatter x=Hippocampus y=ABETA / colorresponse=DX_bl;
run;

proc G3D data=a6;
	 scatter ABETA*Hippocampus=MMSE3 / color=color;
	 note j=r c=purple 'AD' j=r c=blue 'CN' j=r c=green 'EMCI' j=r c=yellow 'LMCI' j=r c=orange 'SMC';
run; quit;
**DX_bl =1 is mixed with 3 and 4 so no linear classifier from all groups is possible;
**Could distinguish between healthy and Alzheimer's if those are the only two groups of interest;
