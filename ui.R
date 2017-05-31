library(shiny)

shinyUI(fluidPage(
  
  titlePanel(title = "Star Transit Relative Flux Grapher"),
  
  sidebarLayout(position = "left",
    sidebarPanel(h4("Upload an image file of an object that transits the star"),
                 "It must be a png or jpeg. Maximum height: 360 pixels. Use a white background (png transparency can't ba handled yet), black for areas where
no light reaches earth and grey tones for areas where it's partly blocked (i.e. translucent areas). The star
                  has a diameter of 360 pixels, so the images of the objects
                 you try might have measures of around 10-100 pixels in each dimension",
                 
                 "The low pixel number was chosen to keep the processing time short.",
                 "\n",
                 
                 fileInput("file1", label = " ", accept = c("image/png", "image/jpeg"),
                           width = "10000px"
                           ),
                 
                 radioButtons("transitmode", "Latitude of transit",
                              c("top" = "top",
                                "middle" = "middle",
                                "bottom" = "bottom"),
                              selected = "middle")
    ),
    mainPanel(h4(textOutput("graphText")), imageOutput("graph"))
  )
))