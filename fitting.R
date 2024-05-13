library(nlstools)
library(ggplot2)
library(tidyr)
tomatoAll <- read.csv("2022Tomato.csv")

tomato <- subset(tomatoAll,Tleaf_set == 23)

formulaExp <- as.formula(A ~ (alpha*Q*Pmax/(alpha*Q+Pmax)-R))

preview(formulaExp, tomato, list(Pmax = 27, alpha = 0.112,R= 1.77))

tomnls <- nls(formulaExp, start = list(Pmax = 30, alpha = 0.12, R = 1.5), data = tomato)

summary(tomnls)

Pnet <- function(Q,pmax,alpha,R){

  X1 = Q*alpha *pmax
  X2 = Q*alpha + pmax
  Pg = X1/X2 - R
  return (Pg)
  
}

Q = 0:1500
p23 = Pnet(Q,26.741, 0.121, 1.7744)
p25 = Pnet(Q,24.619, 0.130, 2.69868)
p27 = Pnet(Q,29.055, 0.137, 2.76456)
p30 = Pnet(Q,30.840, 0.130, 2.86517)
p33 = Pnet(Q,33.807, 0.124, 3.39754)
p35 = Pnet(Q,33.505, 0.120, 3.46129)
Alight = data.frame(Q,p23,p25,p27,p30,p33,p35)
#tomatoA = melt(Alight,id.vars=Q, measure.vars=c(p23,p25,p27,p30,p33,p35))
tomatoA = gather(Alight,key=temperature,value=A,p23:p35)


ggplot(tomatoA,aes(x=Q, y = A, color=temperature))+geom_line()
ggplot(tomatoAll,aes(x=Q,y=A,color=factor(Tleaf_set)))+geom_point()
