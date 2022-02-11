ADNI_new<-ADNI[ which(ADNI$VISCODE=='bl'), ]
ADNI_new <- ADNI_new[,c("MMSE.bl","ABETA.bl","TAU.bl","Ventricles.bl","Hippocampus.bl","WholeBrain.bl","ICV.bl","Age","PTGender")]
ADNI_new <- ADNI_new[complete.cases(ADNI_new),]

#"CA","CDCA"