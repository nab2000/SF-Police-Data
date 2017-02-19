library(shiny)
library(leaflet)
library(rgdal)
source("quicker_cleaning.R")
PDdistricts <- readOGR(dsn = "./Current Police Districts/geo_export_eec04d26-47a2-4219-a422-05158c4bf017.shp")
crime.data <- data.table::fread("SF Data.csv")

function(input, output, session){
    output$map <- renderLeaflet({
        leaflet() %>%
            addTiles(attribution = 'Data comes from <a href="http://data.sfgov.org/">SF Open Data</a>') %>%
            setView(lng = -122.419416, lat = 37.774929, zoom = 12)
    }) 

    df <- reactive({
        input$map
        isolate({
          
            df <- crime.data[crime.data$Year %in% input$year,]
            if(input$pd == "Yes" & 
               input$color == "No" | input$pd == "No"){
                df <- df[df$Category %in% input$cat,]
            } else if (input$pd == "Yes" & 
                       input$color == "Yes"){
                df <- df[df$Category %in% input$color.cat,]
            }
            
            ## This code not working
            if (input$pd == "Yes"){
                df.sort <- SF_sort(file = df, vars = "PdDistrict", date_format = FALSE, 
                                   save_file = FALSE)
                district <-  match(as.data.frame(PDdistricts)$district, rownames(df.sort))
                df.sort$districts <- rownames(df.sort)
                df.sort <- df.sort[district,]
                df.sort <- as.data.frame(df.sort)
                rownames(df.sort) <- as.character(0:9)
                df <- SpatialPolygonsDataFrame(polygons(PDdistricts), data = df.sort)
            }
           
        })
        df
    })
    ##Create data table
    output$table <- DT::renderDataTable({
        df <- df()
        
        if(input$pd == "No"){
            df <- df[,-8:-11]
        } else if (input$pd == "Yes"){
            n <- ncol(df@data)
            df <- df@data[ ,c(n, 1:(n-1))]
            df <- as.data.frame(df)
        }
        df
        })
    ## create map points/polygons
    observe({
        df <- df()
        clust <- markerClusterOptions()
        
        isolate({
            if(input$pd == "No"){
                clr <- colorFactor("RdYlBu", df$Category)
                ## recreate map with new data
                leafletProxy("map") %>%
                    clearMarkerClusters() %>%
                    clearShapes() %>%
                    clearControls() %>%
                    addCircleMarkers(data = df, lng = ~X, lat = ~Y, 
                                     clusterOptions = clust,
                                     popup = ~Resolution,
                                     color = ~clr(Category),
                                     clusterId = ~PdDistrict) %>%
                    addLegend(position = "bottomleft", pal = clr, values = df$Category, 
                              title = "Crime Categories")
            } else if(input$pd == "Yes"){ ##this utilizes the spatialpolygon data frame
                ## This accounts for in input color is No then just district
                if(input$color == "No"){
                    n <- ncol(df@data)
                    ##generate district names
                    popup <- paste(df$districts, " DISTRICT", "<br />",  sep = "")
                    ## Generate results for each Category of Crime
                    for(i in 1:(n-1)){
                        popup <- paste(popup, colnames(df@data)[i], " : ", df@data[,i], 
                                       "<br />", sep = "")
                    }
                    
                    clr.pd <- RColorBrewer::brewer.pal(length(df$districts), "Paired") 
                    leafletProxy("map") %>%
                        clearMarkerClusters() %>%
                        clearShapes() %>%
                        clearControls() %>%
                        addPolygons(data = df, fill =T, opacity = .8, fillOpacity = 0, color = clr.pd,
                                    popup = popup)
                } else if (input$color == "Yes"){
                    ## Generate district names and Crime Number
                    popup <- paste(df$districts, " DISTRICT", "<br />",  
                                   colnames(df@data)[1], " : ", df@data[,1], sep = "")
                    ## Generate color pallete based on Crimes
                    clr.cat <- RColorBrewer::brewer.pal(4, "Reds") 
                    clr <- cut(df@data[,1], 4)
                    lvl <- levels(clr)
                    clr <- factor(clr, levels = lvl, labels = clr.cat)
                    ## Rearrange levels for legened
                    lvl <- gsub("\\(", "", lvl)
                    lvl <- gsub("]", "", lvl)
                    lvl[1] <- gsub(".*,", "< ", lvl[1])
                    lvl[length(lvl)] <- gsub(",.*", "", lvl[length(lvl)])
                    lvl[length(lvl)] <- paste(">",  lvl[length(lvl)])
                    lvl <- gsub( ",", " - ", lvl)
                    ## add map
                    leafletProxy("map") %>%
                        clearMarkerClusters() %>%
                        clearShapes() %>%
                        clearControls() %>%
                        addPolygons(data = df, fill =T, opacity = 1, fillOpacity = 0.8, 
                                    color = clr, popup = popup) %>%
                        addLegend("topleft", colors = clr.cat, labels = lvl,
                                  title = colnames(df@data)[1])
                }
                
            }
                
        })
        
        
        
    })

}

    
    