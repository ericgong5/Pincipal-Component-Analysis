---
title: "Assignment 1"
author: "Eric Gong"
date: "18/02/2022"
output: pdf_document
---

```{r }
library(tidyverse)
library(FactoMineR)
wine_data<-read_csv("red_wine_data.csv") # Be sure this is in your current working directory
glimpse(wine_data)
```

```{r}
wine_data_chem <- wine_data %>% select(-quality)
head(wine_data_chem)


```


```{r}
ggplot(wine_data_chem,aes(x="total sulfur dioxide",y="free sulfur dioxide")) +
  geom_point()

wine_pca<-PCA(wine_data_chem,graph=FALSE,ncp=11)
plot(wine_pca,choix="var")

summary(wine_pca)
eigenvalues_wine<-as.data.frame(wine_pca$eig) %>% 
  rownames_to_column(var="Component")


eigenvalues_wine <- eigenvalues_wine %>% mutate(Component=map_chr(
  Component,~str_split(.x," ")[[1]][2]), Component_num=as.integer(Component), 
  Component=factor(Component_num))


ggplot(eigenvalues_wine,aes(y=eigenvalue,x=Component_num,fill=Component)) +
geom_bar(stat="identity") + geom_line(aes(fill=NULL)) + geom_point()

ggplot(eigenvalues_wine,aes(y=`cumulative percentage of variance`,
                            x=Component_num,fill=Component)) +
  geom_bar(stat="identity") + geom_line(aes(fill=NULL)) + geom_point()

ggplot(eigenvalues_wine,aes(y=`percentage of variance`,x=Component_num,
                            fill=Component)) + geom_bar(stat="identity") + 
  geom_line(aes(fill=NULL)) + geom_point()




```
