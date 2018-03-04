library(shiny)
library(leaflet)
library(lubridate)
library(caret)
library(leaflet)
library(RCurl)
library(rio)
library(readr)




        fluidPage(
               titlePanel("Taxi Cab Tips Predictor - Tip $ / per Mile Prediciton"),


                        sidebarLayout(
                                sidebarPanel(
                                   sliderInput("hour",
                                                 "Time of Fare (nearest hour in 24 hour time):",
                                                 min=1,
                                                max=23,
                                                 value=10
                                ),
                                sliderInput("trip_miles",
                                            "Expected trip miles (Miles):",
                                            min=1,
                                            max=30,
                                            value=24
                                ),
                                sliderInput("fare",
                                            "Expected fare cost (Dollars):",
                                            min=1,
                                            max=100,
                                            value=72
                                ),
                                radioButtons("day_of_week", label = h3("Day of the Week"),
                                             choices = list("Monday" = "Monday", "Tuesday" = "Tuesday","Wednesday"="Wednesday",
                                                            "Thursday"="Thursday","Friday"="Friday","Saturday"="Saturday","Sunday"="Sunday"), 
                                             selected = "Saturday"),
                                radioButtons("payment_type", label = h3("Payment Type Customer wants to use"),
                                             choices = list("Cash" = "Cash", "Credit Card" = "Credit Card"), 
                                             selected = "Cash")
                  ),
                  mainPanel(
                          leafletOutput("mymap"),
                          p(''),
                          actionButton("recalc", "PRESS to Plot the Prediciton",style="background:pink;"),
                          #p('WEST TOWN'),
                          #textOutput('tip1'),
                          #p('NEAR WEST SIDE'),
                          #textOutput('tip2'),
                          #p('LOOP'),
                          #textOutput('tip3'),
                          #p('LINCOLN PARK'),
                          #textOutput('tip4'),
                          #p('LAKE VIEW'),
                          #textOutput('tip5'),
                          #p('MORGAN PARK'),
                          #textOutput('tip6'),
                          #p('CENTRAL'),
                          #textOutput('tip7'),
                          #p('OTHER'),
                          #textOutput('tip8')
                
                          tableOutput('table'),
            
              
                          p(''),
                          p(''),
                          p(''),
                          p(''),
                          p(''),
                          p(''),
                          <a href="">Here are some notes to accompany using this app</a>,
                          p('Thanks to www.kaggle.com for the original dataset'),
                          p('Please note, the data has been summarised significantly and all results presented here should be treated as fictional for the purposes of this assignment.'),
                          p('Original dataset can be found here:'),
                          p('https://www.kaggle.com/chicago/chicago-taxi-rides-2016')
                          
                        )
                  ))
