library(shiny)
library(tidyverse)
library(leaflet)
library(mapview)

ui <- fluidPage(
  leafletOutput("mymap")
)

server <- function(input, output, session) {
  
  name <- c("St. Peter's Cathedral, Adeliade", 
            "Broad Street Pump", 
            "Bletchley Park")
  relevance <- c("The remains of R.A. Fisher are intered here", 
                 "John Snow traced an outbreak of cholera to this location in 1854", 
                 "W. T. Tutte worked here as a code breaker during the war")
  lat <- c(-34.9128, 
           51.513332, 
           51.9977)
  lng <- c(138.5981, 
           -.136642, 
           0.7407)
  remotePath <- c("https://pbs.twimg.com/media/D6nDYPvXoAAenrA.jpg", 
                  "https://pbs.twimg.com/media/D43VCbKWAAAHj_o.jpg", 
                  "https://pbs.twimg.com/media/D6O-1uUW0AEbB0d.jpg"
                  )
  
  df <- tibble(name, relevance, lat, lng, remotePath)
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
                       ) %>%
      addAwesomeMarkers(lat = df$lat, lng = df$lng, 
                        popup = paste(popupImage(df$remotePath, src = c("remote")),
                                      "<br>", df$relevance), 
                        clusterOptions = markerClusterOptions(),
                        label = df$name)
  })
}

shinyApp(ui, server)