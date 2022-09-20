library(tidyverse)
library(Hmisc)
library(superml)
library(ggcorrplot)

#read in file
rdata_df <- read.csv(file='../Resources/2022-College-Guide-Main-Rankings-clear.csv')

#check for file load success
head(rdata_df)

#retrieve list of columns
colnames(rdata_df)

#encode Carnegie Community Engagement column
lbl <- LabelEncoder$new()
lbl$fit(rdata_df$Earns.Carnegie.Community.Engagement.Classification.)
rdata_df$Earns.Carnegie.Community.Engagement.Classification. <- lbl$fit_transform(rdata_df$Earns.Carnegie.Community.Engagement.Classification.)
#decode_names <- lbl$inverse_transform(rdata_df$Earns.Carnegie.Community.Engagement.Classification.)


## IDENTIFY MEANINGFUL CORRELATIONS

#create matrix from df
rdata_matrix <- as.matrix(rdata_df[,c("Rank", "X8.year.graduation.rate", "Graduation.rate.rank", "Predicted.graduation.rate.based.on...of.Pell.recipients..incoming.SATs..etc.", "Graduation.rate.performance.rank", "Pell.non.Pell.graduation.gap", "Pell.graduation.gap.rank", "Number.of.Pell.graduates", "Actual.vs..predicted.Pell.enrollment", "Pell.performance.rank", "Median.earnings.10.years.after.entering.college", "Predicted.median.earnings.10.years.after.entering.college", "Earnings.performance.rank", "Net.price.of.attendance.for.families.below..75.000.income", "Net.price.rank", "X..of.loan.principal.remaining.5.years.later", "Repayment.rank", "Predicted.principal.remaining", "Repayment.rate.performance.rank", "Research.expenditures..in.millions", "Research.expenditures.rank", "Bachelor.s.to.PhD.rank", "Science...engineering.PhDs.awarded", "Science...engineering.PhDs.rank", "Faculty.receiving.significant.awards", "Faculty.in.National.Academies", "Faculty.accolades.rank", "AmeriCorps.Peace.Corps.rank", "ROTC.rank", "X..of.federal.work.study.funds.spent.on.service", "X..of.federal.work.study.funds.spent.on.service.rank", "Earns.Carnegie.Community.Engagement.Classification.", "Voting.engagement.points", "X..of.grads.with.service.oriented.majors", "Service.oriented.majors.rank", "Social.mobility.rank", "Research.rank", "Service.rank")])

#create correlation matrix to view correspondences
cor(rdata_matrix)

#export correlation matrix to CSV
write.csv(cor(rdata_matrix), "testcorr.csv")

#create matrix of both correlation coefficients and p-values; print matrix of p-values to CSV
rcx=rcorr(rdata_matrix)
df.rcx.p=data.frame(rcx$P)
write.csv(df.rcx.p,'correlationmatrix_pvalues.csv')

#visualize correlation matrix as a heatmap and print to png
#more info https://www.statology.org/correlation-matrix-in-r/
png("corr_plot.png")
corr_plot <- ggcorrplot(cor(rdata_matrix)) +
  scale_x_discrete(label = function(x) stringr::str_trunc(x, 12)) +
  scale_y_discrete(label = function(x) stringr::str_trunc(x, 12)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
print(corr_plot)
dev.off()

#generate multiple linear regression model. target = Rank; no feature reduction
summary(lm(Rank ~ X8.year.graduation.rate + Graduation.rate.rank + Predicted.graduation.rate.based.on...of.Pell.recipients..incoming.SATs..etc. + Graduation.rate.performance.rank + Pell.non.Pell.graduation.gap + Pell.graduation.gap.rank + Number.of.Pell.graduates + Actual.vs..predicted.Pell.enrollment + Pell.performance.rank + Median.earnings.10.years.after.entering.college + Predicted.median.earnings.10.years.after.entering.college + Earnings.performance.rank + Net.price.of.attendance.for.families.below..75.000.income + Net.price.rank + X..of.loan.principal.remaining.5.years.later + Repayment.rank + Predicted.principal.remaining + Repayment.rate.performance.rank + Research.expenditures..in.millions + Research.expenditures.rank + Bachelor.s.to.PhD.rank + Science...engineering.PhDs.awarded + Science...engineering.PhDs.rank + Faculty.receiving.significant.awards + Faculty.in.National.Academies + Faculty.accolades.rank + AmeriCorps.Peace.Corps.rank + ROTC.rank + X..of.federal.work.study.funds.spent.on.service + X..of.federal.work.study.funds.spent.on.service.rank + Earns.Carnegie.Community.Engagement.Classification. + Voting.engagement.points + X..of.grads.with.service.oriented.majors +Service.oriented.majors.rank+Social.mobility.rank+Research.rank+Service.rank,data=rdata_df)) 


#generate multiple linear regression model. target = Rank; feature reduction only of 3 subheading ranks (Social mobility rank, Research rank, Service rank)
summary(lm(Rank ~ X8.year.graduation.rate + Graduation.rate.rank + Predicted.graduation.rate.based.on...of.Pell.recipients..incoming.SATs..etc. + Graduation.rate.performance.rank + Pell.non.Pell.graduation.gap + Pell.graduation.gap.rank + Number.of.Pell.graduates + Actual.vs..predicted.Pell.enrollment + Pell.performance.rank + Median.earnings.10.years.after.entering.college + Predicted.median.earnings.10.years.after.entering.college + Earnings.performance.rank + Net.price.of.attendance.for.families.below..75.000.income + Net.price.rank + X..of.loan.principal.remaining.5.years.later + Repayment.rank + Predicted.principal.remaining + Repayment.rate.performance.rank + Research.expenditures..in.millions + Research.expenditures.rank + Bachelor.s.to.PhD.rank + Science...engineering.PhDs.awarded + Science...engineering.PhDs.rank + Faculty.receiving.significant.awards + Faculty.in.National.Academies + Faculty.accolades.rank + AmeriCorps.Peace.Corps.rank + ROTC.rank + X..of.federal.work.study.funds.spent.on.service + X..of.federal.work.study.funds.spent.on.service.rank + Earns.Carnegie.Community.Engagement.Classification. + Voting.engagement.points + X..of.grads.with.service.oriented.majors +Service.oriented.majors.rank,data=rdata_df)) 

#generate multiple linear regression model. target = Social Mobility Rank; features are all features under Social Mobility heading)
summary(lm(Social.mobility.rank ~ X8.year.graduation.rate + Graduation.rate.rank + Predicted.graduation.rate.based.on...of.Pell.recipients..incoming.SATs..etc. + Graduation.rate.performance.rank + Pell.non.Pell.graduation.gap + Pell.graduation.gap.rank + Number.of.Pell.graduates + Actual.vs..predicted.Pell.enrollment + Pell.performance.rank + Median.earnings.10.years.after.entering.college + Predicted.median.earnings.10.years.after.entering.college + Earnings.performance.rank + Net.price.of.attendance.for.families.below..75.000.income + Net.price.rank + X..of.loan.principal.remaining.5.years.later + Repayment.rank + Predicted.principal.remaining + Repayment.rate.performance.rank,data=rdata_df)) 

#inteprtation of summary: https://feliperego.github.io/blog/2015/10/23/Interpreting-Model-Output-In-R
#next: join dataframes (lat/long, forbes/etc. rankings) with python
#show multiple heatmaps relative to ranks for WM, Forbes, USNews
