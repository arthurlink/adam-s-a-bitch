### A.Link 2.12.20: an investigation into data-driven information
#This all started from Z.Levet stating a bunch of facts from a nike website. 
#He was provided a free pair of nike react infinity - this is a new type of marketing: non-sponsor, but trying to become the brand.
#Other people that have done similar reviews: Kofuzi and Nick Bare

###Data and information found in the following links:
#https://www.mensjournal.com/gear/nike-react-infinity-run-shoe/
#https://www.dickpondathletics.com/react-infinity-run-flyknit/ (this was the outcomes - super hard to find)
#https://www.runnersworld.com/uk/gear/shoes/a30453453/nike-react-infinity-run/

###comments on data: finding specs were difficult, each had its own way of saying the same thing
# BCSMRF had an alternative run study (https://www.strava.com/clubs/242200)... there were other studies similar to this; Ryan et al. 2019_run alternative (name change?)
# Alternative run study was locked, who could actually see the data?

### Data summations:
# 60000 miles, 226 participants, 12 weeks, 2 shoe comparison (structure 22 and react infinity)
# training for half-marathon
# log injuries: 3 consecutive days required off to deem as 'injury' = injury does not seem to have been counted, just categorized and lumped together. the days off are the deciding factor
# less pain in knees and feet
# Where did the 52% come from? How many were actually injured within the respective shoe groups?

### Descriptive stats:
60000/226/12/2 # = around 11 mi/shoe/week/person. does that sound adequate? How fast? Project Run 21 identified that ~ 6 mph, ~ 9 mi a week is injury-prone.
3/7 # = little less than half a week of injury? this sound extreme, personally... a recovery day, sure... but, to have multiple days, it sounds like there is bad form and training involved.
226/2 # 113 participants were testing one shoe or the other; 
.303*113; .145*113 # probability of injury; structure 22 (~34):react infinity (~16)
34.239-113; 16.385-113 # absolute/opposite - non-injury (79:97)
1-(16/34) # well that is where the 52% comes from (probability of a proportion). This means nothing without a test of significance, even at the lowest degree, such as a chi-square test.
34.239/78.761;16.385/96.615

### actual analysis:
# I know you cannot have partial people, so I made them integers, No_Injury was rounded up...
S=as.table(rbind(c(34,80),
                 c(16,97)))
dimnames(S)=list(S.T=c("Structure","React"),I.N=c("Injury","Not"))
S
chisq.test(S)

##########################
library(ggplot2)
library(dplyr)
library(MASS)
Input =("
Shoe  I  N Sum
Structure  34 80 113
Infinity 16 97 113
")
#Prop. was in sense of injury: i.e., Injury/No_Injury given respective shoe groups

Shoe= read.table(textConnection(Input),header=TRUE)
# sample size is adequate; was it limited before even doing the descriptive stats? I also assumed normality because the data is nowhere to be found...

Shoe=
  mutate(Shoe,
         Prop=I/Sum)

low=binom.test(34,113)$conf.int[1]
high=binom.test(34,113)$conf.int[2]
low1=binom.test(16,113)$conf.int[1]
high1=binom.test(16,113)$conf.int[2]

Shoe$low.ci=c(low,low1)
Shoe$high.ci=c(high,high1)  
  
d1=position_dodge(width = 0.8)

GG=ggplot(Shoe,
          aes(x=Shoe,y=Prop,fill=Shoe))+
  geom_errorbar(aes(ymax=high.ci, ymin=low.ci), 
                width=0.2, size=0.5, color='black',position = d1)+
  geom_point( size=3, shape=21,position=d1)+
  labs(y='Injury (%), N = 226')+
  scale_y_continuous(limits = c(0,.45))+
  guides(fill=F)+
  scale_fill_manual(values=c('gray70','black','white'))+
  theme(axis.ticks.x=element_blank(),axis.text.x=element_blank())  
GG+theme(panel.background = element_blank(),axis.line=element_line(colour='black'))
