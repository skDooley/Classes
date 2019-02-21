#Q2a.

library(poibin)

monteCarloSampling = function(Td,prob_success,nsims=10){
  sum=0
  for (i in 1:nsims){
    trials = rpoibin(1,prob_success)
    if (trials <= Td){ sum=sum+1 }
  }
  sum/nsims
}

#print(monteCarloSampling(Td,successProbs))

#Q2b.
dpbinom = function(x, prob, log = FALSE, method = c("MC", "PA", "NA", "BA"), nsim = 1e4) {
  prob = 1-prob
  stopifnot(all(prob >= 0 & prob <= 1))
  method <- match.arg(method)
  
  if (method == "PA") {
    # poisson
    dpois(x, sum(prob), log)
  } else if (method == "NA") {
    # normal
    dnorm(x, sum(prob), sqrt(sum(prob*(1-prob))), log)
  } else if (method == "BA") {
    # binomial
    dbinom(x, length(prob), mean(prob), log)
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

#for (case in c("NA","BA","PA","MC")){
#  print(case)
#  print(dpbinom(I0_Pos962$q,successProbs,method=case,log = FALSE))
#}
#How long will this take?
#pos  *indiduals * seconds to simulate / seconds / minutes = #hours
#(1199-764)*3*12/60/60
#install.packages('poibin') #library(poisbinom)
