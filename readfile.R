library(stringr)
library(tidyverse)
library(tidytext)
library(tokenizers)
library(stopwords)


## file reading Function:

readData <- function(filename){
  if(file.exists(filename)){
    path <- paste0(getwd(),"/",filename)
    len <- 0.1*(length(readLines(path)))
    result <- readLines(path,len)
    return(result)
  }else{
    print("Please check file name")
  }
  
}

## file size function
objSize <- function(dt){
  sz <- object.size(dt) / 2^20
  paste("Size of file is",round(sz[1],3),"MB")
}

## tokenization function:

tokenData <- function(ch_data, n_val){
  
  ch_data <- stringr::str_replace_all(ch_data,"[0-9]", " ")
  
  # single words
  if(n_val == 1){
    ch_data <- tokenize_words(ch_data,strip_numeric = TRUE)
    ch_data <- as.data.frame(unlist(ch_data))
    names(ch_data) <- "wd"
    word_count<- ch_data %>% count(wd, sort=TRUE)
  }else if(n_val == "l"){
    ch_data <- tokenize_lines(ch_data)
    ch_data <- as.data.frame(unlist(ch_data))
  }
  ## two words n-gram
  else if(n_val == 2){
    ch_data <- tokenize_ngrams(ch_data,n_min = 2,n = 2)
    ch_data <- as.data.frame(unlist(ch_data))
    names(ch_data) <- "wd"
    word_count<- ch_data %>% count(wd, sort=TRUE)
  }
  
  ## three words n-gram
  else if(n_val == 3){
    ch_data <- tokenize_ngrams(ch_data,n_min = 3,n = 3)
    ch_data <- as.data.frame(unlist(ch_data))
    names(ch_data) <- "wd"
    word_count<- ch_data %>% count(wd, sort=TRUE)
  }
  
  ## four word n-gram
  
  else if(n_val == 4){
    ch_data <- tokenize_ngrams(ch_data,n_min = 4,n = 4)
    ch_data <- as.data.frame(unlist(ch_data))
    names(ch_data) <- "wd"
    word_count<- ch_data %>% count(wd, sort=TRUE)
  }
  else{
    print("Out of bound")
  }
  
  
}

plotData <- function(dt){
  dt <- dt %>% filter(n > 600)
  ggplot(dt,aes(wd,n)) + geom_bar(stat = "identity") +
    labs(title = "Word Histogram", x = "Words", y = "Count")+
    theme(axis.text.x = element_text(angle = 90, face = "bold", colour = "black"),
          axis.title.x = element_text(face = "bold",colour = "black"),
          axis.title.y = element_text(face = "bold",colour = "black")
          )
}

