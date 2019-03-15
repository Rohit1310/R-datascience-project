library(shiny)
library(sqldf)
library(shinyjs)
library(stringr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  getPred <- function(input){
    database = "RJ.Db"
    conn <- dbConnect(SQLite(), database)
    input <- unlist(strsplit(input,split = " "))
    n <- length(input)
    
    if(n >= 3 ){
      base <- str_remove_all(paste(input[(n - 2)],
                    input[(n-1)],
                    input[n]
                    ),"'")
      out <- head((dbGetQuery(conn,
                             sprintf("SELECT DISTINCT predict from token4 where base like '%s'", base)
                             )),
                  n = 10)
      names(out) <- c("predicted words")
      
    }else if(n == 2 ){
      base <- str_remove_all(paste(input[(n-1)],
                    input[n]
                    ),"'")
      out <- head((dbGetQuery(conn,
                             sprintf("SELECT DISTINCT predict from token3 where base like '%s'", base)
                             )),
                  n =10)
      names(out) <- c("predicted words")
      
    }else if(n == 1 ){
      
      base <- str_remove_all(paste(input[n]),"'")
      out <- head((dbGetQuery(conn,
                             sprintf("SELECT DISTINCT predict from token2 where base like '%s'", base)
                             )),
                  n =10)
      names(out) <- c("predicted words")
      
    }else{
      out <- data.frame("Please enter the words....")
      names(out) <- c("Warning")
    }
      
    dbDisconnect(conn)
    if(nrow(out) == 0){
      out <- data.frame("Please change the words.... As the corresponding prediction is Not Found ....")
      names(out) <- c("Notification")
    }
    return((out))
  }
  
  
  txtinput <- reactive({input$txtIn})
  observeEvent(input$pred,output$tab2 <- renderTable({getPred(input$txtIn)})
               )
  
})
