library("EBImage")
  
  pathToCurveForObject = function(objimgpath, latitudemode = "middle", filetype){
    transitmode = latitudemode #middle bottom and top are possible modes.
    rgbkic = readImage("starwithlimbdarkening.png")
    kic = channel(rgbkic, mode = "gray")
    rgbobj = readImage(objimgpath, type = filetype)
    obj = channel(rgbobj, mode="gray")
    
    vertipxreq = ncol(kic)-ncol(obj) #number of addtionally required vertical pixels
    if(transitmode == "top"){
      toppx = 0
      btmpx = vertipxreq
    } else if(transitmode == "middle"){
      toppx = floor(vertipxreq/2)
      btmpx = ceiling(vertipxreq/2)
    } else if (transitmode == "bottom"){
      toppx = vertipxreq
      btmpx = 0
    } else {
      warning("invalid transit method, middle method chosen")
      toppx = floor(vertipxreq/2)
      btmpx = ceiling(vertipxreq/2)
    }
    topwhitemtrx = matrix(rep(1,nrow(kic)*toppx), nrow = nrow(kic), ncol = toppx)
    btmwhitemtrx = matrix(rep(1,nrow(kic)*btmpx), nrow = nrow(kic), ncol = btmpx)
    
    rfluxvalues = c(1)
    c(rfluxvalues, 5)
    animationlength = nrow(obj)+nrow(kic)
    screenshotsAt = floor(quantile(1:animationlength, probs = seq(0,1,.2)))
    scrimages = list()
  
    par(mfrow=c(1,1))
    for(i in 1:animationlength)
    {
      halfobj = obj
      if(i < nrow(obj)){
        halfobj = obj[(nrow(obj)-i+1):nrow(obj),]
      } 
      if(i > nrow(kic)) {
        halfobj = halfobj[0:(nrow(halfobj)-(i-nrow(kic))),]
      } 
    
      leftpx = max(i - nrow(obj), 0)
      rightpx = max(nrow(kic) - i, 0)
      leftwhitemtrx = matrix(rep(1,ncol(halfobj)*leftpx), nrow = leftpx, ncol = ncol(halfobj))
      rightwhitemtrx = matrix(rep(1,ncol(halfobj)*rightpx), nrow = rightpx, ncol = ncol(halfobj))
      objwlrmargin = rbind(leftwhitemtrx, halfobj, rightwhitemtrx)
      objwmargin = cbind(topwhitemtrx, objwlrmargin, btmwhitemtrx)
    
      #adding the object to kic by multiplying the intensities
      dim(objwlrmargin)
      transit = objwmargin * kic
      
      if(i %in% screenshotsAt) scrimages[[(length(scrimages)+1)]] = transit
      
      #calculating the flux of kic without the object
      baseflux = sum(kic) #it's adding the intensities of all pixels (e.g. black: 0, gray: 0.5, white: 1). The black corners don't
      #distort the relative flux results because black has an intensity of 0, so it
      #doesn't matter how much black there is around the star, only the bright pixels
      
      #add to the sum
      transitflux = sum(transit)
      transitrelflux = transitflux/baseflux
      rfluxvalues = c(rfluxvalues, transitrelflux)
    }
    rfluxvalues = c(rfluxvalues, 1)
    
    # Generate a temporary png
    outfile <- tempfile(fileext='.png')
    png(outfile, width=400, height=400)
    nf = layout(matrix(c(2,1), 2,1), c(5,5), c(1,5), T)
    layout.show(nf)
    plot(rfluxvalues, type = "l", xlab = "time (any unit)", xaxt='n', ylab="relative flux")
    axis(side=1, at=screenshotsAt, labels = paste("scrst", 1:length(screenshotsAt)))
    display(do.call(rbind, scrimages), method = "raster", title = "doesnt work")
    dev.off()
    
    #Function output
    outfile
  }
  
  graphCurveForObject = function(objimgpath, latitudemode = "middle", filetype)
  {
    image = readImage(pathToCurveForObject(objimgpath, latitudemode, filetype))
    display(image, method = "raster")
  }
  
  #EXAMPLE
  #graphCurveForObject("intelobj1.png", filetype = "png")
  #pathToCurveForObject("onepercenttriangle.png", "bottom", filetype = "png")