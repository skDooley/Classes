# Homework problem 1

#Install dplyr if you don't already have it
library(dplyr, quietly = T, warn.conflicts = F)

# L(D=d_i | G=g)
log.likelihood.d.g <- function(g, a, m, e, k){
  -k*log(m) +
  sum(log(ifelse(  a == 1, 
                   g * (1 - e) + (m - g) * e/3, 
                   (1 - e) * (m - g) + g * e + (2*e*(m-g))/3 
                 )
          )
      )
}

log.likelihood.MAP <- function(g, a, m, e, k){
  -k*log(m) + log(0.5) +
    sum(
        log(
            ifelse(  a == 1, 
                     g * (1 - e) + (m - g) * e/3, 
                     (1 - e) * (m - g) + g * e + (2*e*(m-g))/3
                  )
        )
    )
}

# Returns a matrix individuals as rows and genotypes as columns
log.likelihood.G <- function(d, m=2, type='g'){
  if (type == 'g'){
    do.call(rbind,
            lapply(split(d, factor(d$i)), function(d_i){
              sapply(0:m, log.likelihood.d.g, a=d_i$a, m=m, e=d_i$e, k=nrow(d_i)) 
            })
    )
  } else {
    do.call(rbind,
            lapply(split(d, factor(d$i)), function(d_i){
              sapply(0:m, log.likelihood.MAP, a=d_i$a, m=m, e=d_i$e, k=nrow(d_i)) 
            })
    )
  }
}

# A helper function for adding logs
# x is a vector of natural logs
logsum <- function(x){
  # adapted from http://andrewgelman.com/2016/06/11/log-sum-of-exponentials/
  logsum2 <- function(a,b){
    max(a,b) + log(exp(a - max(a,b)) + exp(b - max(a,b)))
  }
  Reduce(logsum2, x[-1], x[1])
}

# A wrapper for computing column sums
logcolsums <- function(m){
  apply(m, 2, logsum)
}

# L(psi)
log.likelihood.psi <- function(psi, d, m){
  # L(G=g_i|d_j)f(g_i|m,psi) -- (n_i X n_j matrix)
  A <- t(log.likelihood.G(d,m)) + dbinom(0:m, m, psi, log=TRUE)
  # Now I need to *sum* the log probabilities. This can lead
  # to numeric problems ('Inf' values). It does not cause
  # problems with our particular dataset, though.
  # sumA <- log(colSums(exp(A)))
  # to perform this computation safely:
  sumA <- logcolsums(A)
  
  # Multiply by negative -1 since optim searches for minima
  -1 * sum(sumA)
}
  
#Estimate Psi
estimate.psi <- function(d)
{
  d = prepData(d)
  optim(0.5, log.likelihood.psi, d=d, m=2, method='Brent', lower=0, upper=1)$par
}

#Helper function to process the data between python and R
prepData = function(fileName){
  data = read.table(fileName, header=T)
  data$e = 10^(-(data$q-33)/10.0)
  data
}

log.likelihood.gmap = function(fileName){
  data = prepData(fileName)
  log.likelihood.G(data,type="MAP")
}

log.likelihood.gmap("data/Pos964_data.txt")

# #Read the data
# d962 
# d964 = read.table("data/Pos964_data.txt", header=T)

# #Compute Psi
# d962$e <- 10^(-d962$q/10) # compute error probability once
# d964$e <- 10^(-d964$q/10) # compute error probability once

# #Get MLE
# mle_962 <- estimate.psi(d962)
# mle_964 <- estimate.psi(d964)
# mle_962
# mle_964

# #Graphicing log likelihood for kicks
# require(ggplot2, quietly = T, warn.conflicts = F)
# psi <- seq(from = 1e-6, to = 1-1e-6, length.out = 1000)
# ll <- do.call(rbind, lapply(psi, log.likelihood.psi, d = d964, m = 2))
# ll.plot <- data.frame(psi = psi, ll = ll)
# ggplot(ll.plot, aes(x = psi, y = -ll)) + geom_line() +labs(y = "log likelihood", x = expression(psi))









