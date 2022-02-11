ADNI_new<-ADNI[ which(ADNI$VISCODE=='bl'), ]
ADNI_new <- ADNI_new[,c("MMSE","ABETA","TAU","Ventricles","Hippocampus","WholeBrain","ICV","AGE","PTGENDER","PTEDUCAT","PTMARRY","PTETHCAT","PTRACCAT")]
ADNI_new <- ADNI_new[complete.cases(ADNI_new),]