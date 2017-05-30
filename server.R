library(shiny)
library("EBImage")
source("StarTransitRelFluxGrapher.R")

shinyServer(
  function(input, output){

    
    output$file1 = renderImage(
      {

        # # A temp file to save the output. It will be deleted after renderImage
        # # sends it, because deleteFile=TRUE.
        # outfile <- tempfile(fileext='.png')
        #
        # # Generate a png
        # png(outfile, width=400, height=400)
        # hist(rnorm(100))
        # dev.off()
        #
        # # Return a list
        # list(src = outfile,
        #      alt = "This is alternate text")


        #filename <- normalizePath(file.path('./images',
        #                                   paste('image', input$n, '.jpeg', sep='')))

        print(str(input$file1))
        # Return a list containing the filename
        list(src = input$file1$datapath)
      }, deleteFile = FALSE)
    
    output$graph = renderImage(
      {
        # outfile <- tempfile(fileext='.png')
        # 
        # # Generate a png
        # png(outfile, width=400, height=400)
        # curveForObject("twopercenttriangle.png", "top")
        # dev.off()

        # Return a list
        
        
        #input$file1 = fixUploadedFilesNames(input$file1)
        
        MIMEfiletype = input$file1$type
        filetypestring = strsplit(MIMEfiletype, "/")[[1]][2]
        
        file.copy(input$file1$datapath, paste0(input$file1$datapath, ".", filetypestring))
        fullPathToObject = paste0(input$file1$datapath, ".", filetypestring)
        
        print("output$graph, filepath, str")
        print(fullPathToObject)
        print(str(input$file1))
        
        list(src = pathToCurveForObject(fullPathToObject, input$transitmode, filetype = filetypestring),
             alt = "This is alternate text")
      }, deleteFile = FALSE)
    
    
    output$weirdobject = renderImage({
      list(src = "./www/weirdobject.png")
    })
    
    # output$click_info <- renderPrint({
    #   cat("input$image_click:\n")
    #   str(input$image_click)
    # })
    
    
}
)