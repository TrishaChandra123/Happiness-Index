---
title: "World Happiness Index"
author: "Trisha Chandra"
date: "March 29, 2019"
output:
  html_document: default
  word_document: default
---

#Dataset
The dataset presented here is 'World Happiness Index' 2016 data which I found on Kaggle. It consists of happiness scores and ranks of around 160 countries based on 7 facots: family, life expectancy, economy, generosity, trust in government, freedom, and dystopia residual which tell to what extent these facotrs affect the happines score. Dystopia has the lowest happiness level and is considered as a referenece for other regions to display how far they are from being the least happy country. Happiness score is the sum of the values of all the other factors.

#Report
The report visualizes the data using various R libraries and presents insights on what factors affect the happiness scores, which regions are the happiest and which factors are considered imporant in those regions for happiness. Based on this analysis we can deteremine the factors that the countries must focus on to achieve higher happiness levels.

```{r, echo=FALSE, message=F, warning=F}
data1 <- read.csv("C:/Users/tchandra/Desktop/Work/ML/Projects/World Happiness Report/world-happiness-report/2016.csv")
data <- data1[,-c(1,11)]
```

#Visualization

The visualization consists of boxplots, corelation matrices and scatterplots. Based on these plots we determine the factors that affect the happiness scores the most. My purpose here is to demonstrate various types of charts that can be used to reiterate the same idea and validate the results. I have used packages like plotly, corrplot, PerformanceAnalytics, corrgram, ggplot2 to develop these visualizations.

##Boxplot

Boxplot is used here to show variation in the happiness scores for all the regions and compare the median happiness scores for different regions. Looking at the plot below we see that Australia has the highest median value of happiness score while Africa has the lowest. 

```{r, echoes=FALSE, message=F, warning=F}

library(plotly)
par(mfrow=c(3,1))
plot_ly(data,x=~Region,
        y=~Happiness.Score,
        type="box",
        boxpoints="all",
        pointpos = -1.8,
        color=~data$Region)
```

##Correlation Matrix

A correlation matrix is used here to determine the correlation between the factors and the happiness score. Based on the plot below we see that the top three factors that contribute most to the happiness score are GDP, Family and Life Expectancy 

```{r, echoes=FALSE, message=F, warning=F}

library(corrplot)
d1 <- data[,-c(1)]
corrplot(cor(d1), method = 'color')
corrplot(cor(d1), method = 'number')
```

##Correlation Chart

Correlation chart from the Performance Analytics package is used here.
This plot reiterates that the top three factors that contribute most to the happiness score are GDP, Family, Life Expectancy and also points out that there's not really a significant correlation between Generosity and Happiness Score.

```{r, echoes=FALSE, message=F, warning=F}

library(PerformanceAnalytics)
chart.Correlation(d1, histogram = TRUE, pch =19)
```

##Correlation Plot

Next few visualizations represent the correlation matrix of factors vs happiness scores for indiviudal regions.

```{r, echoes=FALSE, message=F, warning=F}

library(corrgram)
attach(data)
corrgram(data[which(Region == "Africa"),],order =FALSE ,upper.panel=panel.cor, main = "Happiness Correlation Plot for Africa")
```

We can see that for Africa, GDP and Life Expectancy play an improtant role in happiness.


```{r, echoes=FALSE, message=F, warning=F}
corrgram(data[which(Region == "Asia"),],order =FALSE ,upper.panel=panel.cor, main = "Happiness Correlation Plot for Asia")
```

For Asia again GDP and Life Expectancy plays an improtant role in happiness.

```{r, echoes=FALSE, message=F, warning=F}
corrgram(data[which(Region == "Australia"),],order =FALSE ,upper.panel=panel.cor, main = "Happiness Correlation Plot for Australia")
```

Since Australia region consists of only twi regions Australia and New Zealand, results are skewed.

```{r, echoes=FALSE, message=F, warning=F}
corrgram(data[which(Region == "Europe"),],order =FALSE ,upper.panel=panel.cor, main = "Happiness Correlation Plot for Europe")
```

For Europe, GDP and Freedom seem to play important role in happiness

```{r, echoes=FALSE, message=F, warning=F}
corrgram(data[which(Region == "North America"),],order =FALSE ,upper.panel=panel.cor, main = "Happiness Correlation Plot for North America")
```

North America, same as Asia and Africa values GDP and Life Expectancy for happiness.

```{r, echoes=FALSE, message=F, warning=F}
corrgram(data[which(Region == "South America"),],order =FALSE ,upper.panel=panel.cor, main = "Happiness Correlation Plot for South America")
```

South America, follows the lead of the majority of the regions valuing GDP and Life Expectancy for happiness.

##Scatterplot with regression line

In this section we will analyse the seven factors vs happiness scores for different regions using a Scatter plot with regression line

```{r,echoes=FALSE, message=F, warning=F}

library(ggplot2)
ggplot(subset(data), aes(x = GDP, y = Happiness.Score)) + geom_point(aes(color = Region), size = 4, alpha = 0.5) + geom_smooth(aes(color = Region, fill = Region), method = "lm", fullrange = TRUE) + facet_wrap(~Region) + theme_bw() + labs(title = "Scatter plot with Regression Line: GDP Vs Happiness Score")
```

We can see that Happiness Score increases with increase in GDP for Africa, Asia and Europe. There is no significat trend for North and South America.

```{r, echoes=FALSE, message=F, warning=F}
ggplot(subset(data), aes(x = Family, y = Happiness.Score)) + geom_point(aes(color = Region), size = 4, alpha = 0.5) + geom_smooth(aes(color = Region, fill = Region), method = "lm", fullrange = TRUE) + facet_wrap(~Region) + theme_bw() + labs(title = "Scatter plot with Regression Line: Family Vs Happiness Score")
```

For most regions there's no significant trend between Family and Happiness Score.

```{r, echoes=FALSE, message=F, warning=F}
ggplot(subset(data), aes(x = Life.Expectancy, y = Happiness.Score)) + geom_point(aes(color = Region), size = 4, alpha = 0.5) + geom_smooth(aes(color = Region, fill = Region), method = "lm", fullrange = TRUE) + facet_wrap(~Region) + theme_bw() + labs(title = "Scatter plot with Regression Line: Life Expectancy Vs Happiness Score")
```

Similar, there's no significant trend between Life Expectancy and Happiness Score.

```{r, echoes=FALSE, message=F, warning=F}
ggplot(subset(data), aes(x = Freedom, y = Happiness.Score)) + geom_point(aes(color = Region), size = 4, alpha = 0.5) + geom_smooth(aes(color = Region, fill = Region), method = "lm", fullrange = TRUE) + facet_wrap(~Region) + theme_bw() + labs(title = "Scatter plot with Regression Line: Freedom Vs Happiness Score")
```

For Europe, as we saw before in one of the previous correlation charts, there's a significant trend between Freedom and Happiness Score

```{r, echoes=FALSE, message=F, warning=F}
ggplot(subset(data), aes(x = Corruption, y = Happiness.Score)) + geom_point(aes(color = Region), size = 4, alpha = 0.5) + geom_smooth(aes(color = Region, fill = Region), method = "lm", fullrange = TRUE) + facet_wrap(~Region) + theme_bw() + labs(title = "Scatter plot with Regression Line: Corruption Vs Happiness Score")
```

For most regions there's no significant trend between Corruption and Happiness Score

```{r, echoes=FALSE, message=F, warning=F}
ggplot(subset(data), aes(x = Generosity, y = Happiness.Score)) + geom_point(aes(color = Region), size = 4, alpha = 0.5) + geom_smooth(aes(color = Region, fill = Region), method = "lm", fullrange = TRUE) + facet_wrap(~Region) + theme_bw() + labs(title = "Scatter plot with Regression Line: Generosity Vs Happiness Score")
```

Again, there's no strong correlation between Generosity and Happiness Score, in fact it shows a downward trend for countries like Africa, Asia and North America.

```{r, echoes=FALSE, message=F, warning=F}
ggplot(subset(data), aes(x = Dystopia.Residual, y = Happiness.Score)) + geom_point(aes(color = Region), size = 4, alpha = 0.5) + geom_smooth(aes(color = Region, fill = Region), method = "lm", fullrange = TRUE) + facet_wrap(~Region) + theme_bw() + labs(title = "Scatter plot with Regression Line: Dystopia Residual Vs Happiness Score")
```

Finally, again, there's no significant trend between Dystopia Residual and Happiness Score.

#Colunclusion 

For most regions we saw that improving GDP, Life Expectancy and to some extent Family would be a way to achieve happiness and increase the happines scores. If the governments of the countries invest in improving these factors, they would be able to improve happiness among its citizens.
