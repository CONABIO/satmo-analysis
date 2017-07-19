# Time-series extraction function (ellipsis is for raster::extract())
# sp is a Spatial* object
tsExtract <- function(x, sp, ...) {
    val <- extract(x, sp, ...)
    dates <- getZ(x)
    return(zoo(t(val), dates))
}

# Extract directly from long/lat pair
# x is a rasterBrick with time written to the z dimension
# ... goes to raster::extract() (via tsExtract)
tsExtractCoords <- function(x, long, lat, ...){
    longlat <- data.frame(long = -94, lat = 19)
    sp <- SpatialPoints(coords = longlat, proj4string = CRS('+proj=longlat')) %>%
        spTransform(CRS(projection(x)))
    tsExtract(x, sp, ...)
}