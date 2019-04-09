install.packages('expm')
library('expm')

setwd("~/Desktop/R")

pi <- c(.25,.25,.25,.25)
print(pi)

rate <- c(.25,.25,.25,.25,.25)
print(rate)


rowAdia = 0 - (rate[1]*pi[2] + rate[2]*pi[3] + rate[3]*pi[4])
  print(rowAdia)
rowCdia = 0 - (rate[1]*pi[1] + rate[4]*pi[3] + rate[5]*pi[4])
  print(rowCdia)
rowGdia = 0 - (rate[2]*pi[1] + rate[4]*pi[2] + 1*pi[4])
  print(rowGdia)
rowTdia = 0 - (rate[3]*pi[1] + rate[5]*pi[2] + 1*pi[4])
  print(rowTdia)

data.x <- c(rowAdia, rate[1]*pi[2], rate[2]*pi[3], rate[3]*pi[4],
            rate[1]*pi[1], rowCdia, rate[4]*pi[3], rate[5]*pi[4],
            rate[2]*pi[1], rate[4]*pi[2], rowGdia, 1*pi[4],
            rate[3]*pi[1], rate[5]*pi[2], 1*pi[4], rowTdia)
matrix.x <- matrix(data.x, nrow = 4, ncol = 4, byrow = TRUE)
print(matrix.x)

avals <- diag(matrix.x)
print(avals)


mults <- (avals * pi)
print(mults)
sums <- sum(mults)
print(sums)

As <- -(matrix.a/sums)
print(As)


P_01 = expm(As*.01) 
print(P_01)

n = 10

Pn = P_01^(n)
print(Pn)

P2n = P_01^(2*n)
print(P2n)
