library(sqldf)

# Writting the tokenized data to the MYSQLite database 
setData <- function(gramVal){
  database = "RJ.Db"
  conn <- dbConnect(SQLite(), database)
  dbListTables(conn)

# writting the data to the database.
  dbWriteTable(conn, "token2", value = as.data.frame(gram2), row.names = FALSE)
  dbWriteTable(conn, "token3", value = as.data.frame(gram3), row.names = FALSE)
  dbWriteTable(conn, "token4", value = as.data.frame(gram4), row.names = FALSE)

  dbDisconnect(conn)
}

## prediction Function
getPred <- function(input){
  database = "RJ.Db"
  conn <- dbConnect(SQLite(), database)
  input <- unlist(strsplit(input,split = " "))
  n <- length(input)
  
  if(n >= 3 ){
    base <- paste(input[(n - 2)],
                  input[(n-1)],
                  input[n]
    )
    out <- head((dbGetQuery(conn,
                            sprintf("SELECT DISTINCT predict from token4 where base like '%s'", base)
    )),
    n = 10)
    names(out) <- c("predicted words")
    
  }else if(n == 2 ){
    base <- paste(input[(n-1)],
                  input[n]
    )
    out <- head((dbGetQuery(conn,
                            sprintf("SELECT DISTINCT predict from token3 where base like '%s'", base)
    )),
    n =10)
    names(out) <- c("predicted words")
    
  }else if(n == 1 ){
    
    base <- paste(input[n])
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
  return((out))
}

