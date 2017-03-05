altfreq <- function(df){
  prop <- rep (0, nrow(df))
  print (nrow(df))
  #output2 <- rep (0, nrow(df))
  Ref <- rep (0, nrow(df))
  Alt <-rep (0, nrow(df))
  
  for (i in seq(1,nrow(df))){
  
    Ref[i] <- ((df[i,4]*2)+(df[i,5])+(df[i,6]*2)+
      (df[i,7])+(df[i,8])+(df[i,9]*2)+
      (df[i,10])+(df[i,11])+(df[i,12])+(df[i,13]*2))
    
    Alt[i] <- ((df[i,5])+(df[i,6]*2)+(df[i,7])+
      (df[i,8])+(df[i,9]*2)+(df[i,10])+
      (df[i,11])+(df[i,12])+(df[i,13]*2))
    prop[i] <- Alt[i]/Ref[i]
  }
  #return(list(Ref=Ref,Alt=Alt,prop=prop))
  return(prop)
}



thres <- function (x){
  print(length(sort(x, decreasing =TRUE)))
  normalized <- (x)/max(x,na.rm = TRUE)
  sort_x <- sort(normalized,decreasing = TRUE)
  score <- rep (0, 10)
  for (i in c(1:length(score))) {
    print (i)
    threshold <-  c(0.95, 0.90, 0.85, 0.80, 0.75, 0.70, 0.65, 0.5, 0.35,0.25)
    score[i] <- length(which(sort_x > threshold[i]))
  }
  return(score)
}
