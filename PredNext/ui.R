library(shiny)
library(shinyjs)

# Define UI for application
shinyUI(fluidPage(
  useShinyjs(),
  titlePanel(title = "",windowTitle = "Next Word Prediction"),
  fluidRow(
    column(width = 12,div(
      img(style="display:inline;border-style: solid;padding: 10px;",
          src='logo.JPG',
          width = "200",
          height = "100"),
      h1(style="display:inline;color: black;padding: 50px;text-align:center;background-color: white;font-size: 30px;font-family: calibri;color:DodgerBlue;",
         "Next Word Prediction Application (A NLP Project)")))
  ),
  
 # Layout
  sidebarLayout(
 # Input panel
    sidebarPanel(
      HTML('<h2 style="font-family:calibri; color:DodgerBlue  ;" >Input Panel</h2>'),
       textAreaInput("txtIn","Input Sentence",placeholder = "Please enter your string here"),
       actionButton("pred","Predict",icon = icon("eye"))
    ),
    
  # To show the results
    mainPanel(
       tabsetPanel(
         tabPanel("Welcome",
                  HTML('<h4 style="font-family:calibri; color:DodgerBlue  ;" >Disclaimer</h4>
                       <p style="font-family:calibri;">This is a NLP Project for which I have developed this R-shiny application to predict the next word
                        of the user provided sentence. The user is responsible to ensure the validity of the sentence.This Welcome page is intended to be a tool
                        to facilitate the use of the application.</p>

                       <h4 style="font-family:calibri; color:DodgerBlue  ;" >How To</h4>
                       <p style="font-family:calibri;"> This is a fairly simple to use application. Application usage steps are as follows: </p>
                       <ol type = "1" style="font-family:calibri;">
                       <li> Go to "Prediction" Tab </li>
                       <li>Write the sentence in the "Input Sentence" on the left</li>
                       <li> Click on the "Predict" button </li>
                       <li>The predicted worlds will be shown in the "Prediction" tab </li>
                        <li>Thereafter keep writing new worlds, the respective predicted word will be populated in the "Prediction" tab </li>
                       </ol>
                       
                      <h4 style="font-family:calibri; color:DodgerBlue  ;" >Tasks behind the scenes</h4>
                      <ul style="list-style-type:disc;font-family:calibri">
                      <li>I have used the some twitter posts, News Articles, and Blogs
                        which has been provided by the Cousera in collaboration with Swiftkey as Training Data, to train my models and use for the prediction.</li>
                      <li> Cleand the data to be used to create the model using R</li>
                      <li>Created n-grams from the clean data ranging from 1 to 4 and stored the ngram into an R MySQLite database</li>
                      <li> Katz back-off model for predicting</li>
                      </ul>
                      <h2 style = "font-familt:calibri; color: DodgerBlue;"> <b>THANK YOU!!! Please Use the Application .....</b></h2>
                      ')
                  ),
         tabPanel("Prediction",HTML('<h4 style="font-family:calibri; color:DodgerBlue  ;" >Prediction shown below</h4>'),
                  tableOutput("tab2")
                  )
       )
    )
  )
))
