### A.Link 2.12.20: an investigation into data-driven information
#This all started from Z.Levet stating a bunch of facts from a nike website. 
#He was provided a free pair of nike react infinity.

###Data found in the following links:
#https://www.dickpondathletics.com/react-infinity-run-flyknit/ (this was the outcomes - super hard to find)
#
shoe=c('22','React')
injury=c(34,16)
noinjury=c(79,97)
shoe=data.frame(shoe,injury,noinjury)
chisq.test(shoe$noinjury,shoe$injury, correct = F)
