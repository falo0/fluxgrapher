library(shiny)
library("EBImage")
source("StarTransitRelFluxGrapher.R")

shinyServer(
  function(input, output){
    output$graphText = renderText({
      if(is.null(input$file1)){
        return("Example Graph")
      }
      "Graph based on your object"
    })
    
    output$graph = renderImage({
        if(is.null(input$file1)){
          return(list(src = "./www/4percenttriangle_examplegraph.png"))
        }
          
        MIMEfiletype = input$file1$type
        filetypestring = strsplit(MIMEfiletype, "/")[[1]][2]
        
        file.copy(input$file1$datapath, paste0(input$file1$datapath, ".", filetypestring))
        fullPathToObject = paste0(input$file1$datapath, ".", filetypestring)
        
        print("output$graph, filepath, str")
        print(fullPathToObject)
        print(str(input$file1))
        
        list(src = pathToCurveForObject(fullPathToObject, input$transitmode, filetype = filetypestring))
      }, deleteFile = TRUE)
}
)