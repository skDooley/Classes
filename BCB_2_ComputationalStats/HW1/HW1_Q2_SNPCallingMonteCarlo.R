# Install poisson-binomial library if not already installed
#install.packages('poisbinom')

library(poisbinom)


I_0_Pos962 = read.table("data/Pos962_data.txt", header=T)
I_0_Pos962$e = (1-)

nsims = 10
num_observed_ref_alleles = sum(I_0_Pos962$a)
coverage = length(I_0_Pos962$a)
calls = I_0_Pos962$a

reps = replicate(nsims, rpoisbinom(num_observed_ref_alleles,calls))

help(rpoisbinom)

pp = runif(500)
pp
rpoisbinom(50,calls)
reps
colSums(reps)
pvalue=sum(colSums(reps))/nsims


repTable/sum(repTable)


tmp <- tmp/sum(tmp)


pvalue = colSums(reps) / nsims



pvalue

colSums(reps)       
reps
tmp <- table(colSums(reps))
tmp <- tmp/sum(tmp)
p <- as.numeric(tmp[as.character(qscores)])
p
p[is.na(p)] <- 0
p








dpbinom <- function(x, prob, log = FALSE, method = c("MC", "PA", "NA", "BA"), nsim = 1e4) {
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
    tmp <- table(colSums(replicate(nsim, rpoisbinom(length(x)*.1,x))))
    tmp <- tmp/sum(tmp)
    p <- as.numeric(tmp[as.character(x)])
    p[is.na(p)] <- 0
    
    if (log) log(p)
    else p 
  }
}

d962$e <- 10^(-d962$q/10)

dpbinom(d962$e,1,method='PA')
