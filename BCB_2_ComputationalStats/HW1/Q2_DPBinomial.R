#Q2a.


#Q2b.
dpbinom = function(x, prob, log = FALSE, method = c("MC", "PA", "NA", "BA"), nsim = 1e4) {
  prob = 10^(-(prob-33)/10)
  #print(prob)
  stopifnot(all(prob >= 0 & prob <= 1))
  method <- match.arg(method)
  
  if (method == "PA") {
    # poisson
    ppois(x, sum(prob), log)
  } else if (method == "NA") {
    # normal
    pnorm(x, sum(prob), sqrt(sum(prob*(1-prob))), log)
  } else if (method == "BA") {
    # binomial
    pbinom(x, length(prob), mean(prob), log)
  } else {
    
    # monte carlo
    tmp <- table(colSums(replicate(nsim, rbinom(length(prob), 1, prob))))
    tmp <- tmp/sum(tmp)
    p <- as.numeric(tmp[as.character(x)])
    p[is.na(p)] <- 0
    
    if (log) log(p)
    else p 
  }
}




####################### Development Artifacts below here #######################
#for (case in c("NA","BA","PA","MC")){
#  print(case)
#  print(dpbinom(I0_Pos962$q,successProbs,method=case,log = FALSE))
#}
#How long will this take?
#pos  *indiduals * seconds to simulate / seconds / minutes = #hours
#(1199-764)*3*12/60/60
#install.packages('poibin') #library(poisbinom)

#library(poibin)

#print(monteCarloSampling(Td,successProbs))
# monteCarloSampling = function(Td,prob_success,nsims=10){
#   sum=0
#   for (i in 1:nsims){
#     trials = rpoibin(1,prob_success)
#     if (trials <= Td){ sum=sum+1 }
#   }
#   sum/nsims
# }
