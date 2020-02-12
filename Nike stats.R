### A.Link 2.12.20: an investigation into data-driven information
#This all started from Z.Levet stating a bunch of facts from a nike website. 
#He was provided a free pair of nike react infinity - this is a new type of marketing: non-sponsor, but trying to become the brand.
#Other people that have done similar reviews: Kofuzi and Nick Bare

###Data found in the following links:
#https://www.mensjournal.com/gear/nike-react-infinity-run-shoe/
#https://www.dickpondathletics.com/react-infinity-run-flyknit/ (this was the outcomes - super hard to find)
###comments on data: finding specs were difficult, each had its own way of saying the same thing
# BCSMRF had an alternative run study... there were other studies similar to this; Ryan et al. 2019_run alternative


shoe=c('22','React')
injury=c(34,16)
noinjury=c(79,97)
shoe=data.frame(shoe,injury,noinjury)
chisq.test(shoe$noinjury,shoe$injury, correct = F)
#So, there is no significant difference between treatment and control
