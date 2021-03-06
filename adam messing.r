#so, I think I found out how to update stuff from Rstudio. This should be seen if so.


### A.Link 12.11 - Julz code for pre-post analysis
#I was watching the judiciary committee debate on the articles of impeachments while writing this, pardon if I have jumps in thought or seem inconsistent
pre.per=c(10,8,7,6,5,7);sum(pre.per);post.per=c(10,10,9,10,8,9);sum(post.per)
mean(pre.per)#so this allows you to see your average, feel free to do that to each after.
pre.val=c(8,5,7,6,6,8);post.val=c(10,10,9,10,8,10)
pre.int=c(8,10,8,0,6,10);post.int=c(10,10,9,10,8,10)
pre.mot=c(10,3,7,10,7,10);post.mot=c(10,10,10,8,10,9)
pre.att=c(8,8,8,7,7,8);post.att=c(9,10,10,10,9,10)
pre.ide=c(8,7,7,6,7,7);post.ide=c(10,10,8,10,7,10)
pre.exp=c(7,9,7,7,7,8);post.exp=c(8,10,9,10,8,10)
pre.emo=c(8,7,7,3,8,9);post.emo=c(10,10,10,10,9,10)
pre.und=c(2,7,8,5,5,10);post.und=c(8,7,10,9,7,8)
pre.ret=c(10,10,7,3,5,10);post.ret=c(10,10,8,10,7,10)#check the environment, all have 1:6, so numbers still might be wrong (account for that)

#so data now is there, make into a frame to conduct an analysis
pre=c(10,8,7,6,5,7,8,5,7,6,6,8,8,10,8,0,6,10,10,3,7,10,7,10,8,8,8,7,7,8,8,7,7,6,7,7,7,9,7,7,7,8,8,7,7,3,8,9,2,7,8,5,5,10,10,10,7,3,5,10)
post=c(10,10,9,10,8,9,10,10,9,10,8,10,10,10,9,10,8,10,10,10,10,8,10,9,9,10,10,10,9,10,10,10,8,10,7,10,8,10,9,10,8,10,10,10,10,10,9,10,8,7,10,9,7,8,10,10,8,10,7,10)
x=data.frame(pre,post)
#okay, time to differenciate 
type=c(rep('per',6),rep('val',6),rep('int',6),rep('mot',6),rep('att',6),rep('ide',6),rep('exp',6),rep('emo',6),rep('und',6),rep('ret',6))
x$type=as.factor(type)

#suggest a summary package like rmisc
library(Rmisc)
p=group.CI(pre~type,x)#from this you can find your greatest and lowest pre-test
min(p[3]);max(p[3])#min=und, max=mot
pp=group.CI(post~type,x)#again, extract your highest,lowest
min(pp[3]);max(pp[3]) #min=und, max=emo

# try graphing - I think
library(ggplot2)
d1=position_dodge(width = 0.8)
dd=8

g1=ggplot(pp,
          aes(x=type,y=post.mean,fill=type))+
  geom_errorbar(aes(ymax=post.upper, ymin=post.lower), 
                width=0.2, size=0.5, color="black",position = d1)+
  geom_point( size=3, shape=21,position=d1)
g1
### present thoughts... its nice to see your assumed plotted data, but lets find the difference which better shows the effect
# going to edit the frame, add a column

#difference between pre-post (what most people care about): assumption of paired samples (check again for data, feel free to reasign values above in lines 2-12)
x$diff=x$post-x$pre #this will provide positives (if the treatment is effective - hypothesis/null of zero, correct?)

#so try graphing again - accounting for assumption
#test for assumption - seems a little left skewed
hist(x$diff) #I would run a non-parametric test, but consider the grouping effects too

plot(diff~type,x)#outliers of emo, inf, ref (not too bad though, in my opinion)
#chose not to transform, lose some data
p1=group.CI(diff~type,x)

g2=ggplot(p1,
          aes(x=type,y=diff.mean,fill=type))+
  geom_errorbar(aes(ymax=diff.upper,ymin=diff.lower),
                width=0.2,size=0.5,color='black',position=d1)+
  geom_point( size=3, shape=21,position=d1)+
  geom_hline(yintercept = 0,linetype='dashed',color='gray')+
  labs(x='Learning Objective',y=expression('Score effect size,CI 95'),size=dd)+
  theme(axis.ticks.x=element_blank())+
  theme_classic()+
  guides(fill=F)
