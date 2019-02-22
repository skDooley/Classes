#Q2a.


#Q2b.
dpbinom = function(x, prob, log = FALSE, method = c("MC", "PA", "NA", "BA"), nsim = 1e4) {
  prob = 1-10^(-(prob-33)/10)
  stopifnot(all(prob >= 0 & prob <= 1))
  method <- match.arg(method)
  if (method == "PA") {
    # poisson
    ppois(x, sum(prob), log.p=log)
  } else if (method == "NA") {
    # normal
    pnorm(x, sum(prob), sqrt(sum(prob*(1-prob))), log.p=log)
  } else if (method == "BA") {
    # binomial
    pbinom(x, length(prob), mean(prob), log.p=log)
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





# d768 = read.table("data/I0_Pos768_data.txt", header=T)
# d962 = read.table("data/Pos962_data.txt", header=T)

# dpbinom(8869,d768$q,method="PA", log = FALSE) #Homo -> close to 1
# 1-ppois(8869,8865.613,FALSE)
# dpbinom(4827,d962$q,method="PA", log = FALSE) #het -> close to 0
# ppois(4827,8865.006)


# d768$e = 1- 10^(-(d768$q-33)/10)
# d962$e = 1- 10^(-(d962$q-33)/10)

# sum(d768$e)
# sum(d962$e)

# ppois(8869, lambda=sum(d768$e),log=FALSE)
# ppois(4827, sum(d962$e),log=FALSE )





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
help(ppois)
