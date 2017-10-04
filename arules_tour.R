library("arules")

### University of California, Irvine US Census data on adults
data("AdultUCI")
dim(AdultUCI)
### [1] 48842    15
AdultUCI[1:2,]

### Remove undesired attributes
AdultUCI[["fnlwgt"]] <- NULL
AdultUCI[["education-num"]] <- NULL
AdultUCI[["age"]] <- cut(AdultUCI[["age"]], c(15,25,45,65,100), labels = c("Young", "Middle-aged", "Senior", "Old"), ordered=TRUE)

### Change numbers into categories
AdultUCI[["hours-per-week"]] <- cut(AdultUCI[["hours-per-week"]], c(0,25,40,60,168), labels = c("Part-time", "Full-time", "Over-time", "Workaholic"), ordered=TRUE)
AdultUCI[["capital-gain"]] <- cut(AdultUCI[["capital-gain"]], c(-Inf,0, median(AdultUCI[["capital-gain"]][AdultUCI[["capital-gain"]]>0]),Inf), labels = c("None", "Low", "High"), ordered=TRUE)
AdultUCI[["capital-loss"]] <- cut(AdultUCI[["capital-loss"]], c(-Inf,0, median(AdultUCI[[ "capital-loss"]][AdultUCI[[ "capital-loss"]]>0]),Inf), labels = c("none", "low", "high"), ordered=TRUE)

### Formats as needed...binary incidence matrix
Adult <- as(AdultUCI, "transactions")
Adult

summary(Adult)

itemFrequencyPlot(Adult, support = 0.1, cex.names=0.8)

rules <- apriori(Adult, parameter = list(support = 0.01, confidence = 0.6))

rules

summary(rules)

rulesIncomeSmall <- subset(rules, subset = rhs %in% "income=small" & lift > 1.2)
rulesIncomeLarge <- subset(rules, subset = rhs %in% "income=large" & lift > 1.2)

inspect(head(SORT(rulesIncomeSmall, by = "confidence"), n = 3))

inspect(head(SORT(rulesIncomeLarge, by = "confidence"), n = 3))

WRITE(rulesIncomeSmall, file = "data.csv", sep = ",", col.names = NA)

library("pmml")
rules_pmml <- pmml(rulesIncomeSmall)
saveXML(rules_pmml, file = "adultcensus.xml")
