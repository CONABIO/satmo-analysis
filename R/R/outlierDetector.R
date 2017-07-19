# Function to detect whether each observation of a prepared dataframe (with precomputed residuals) is an outlier or not
outlierDetector <- function(df, sensitivity=1.5){
    resid.q <- quantile(df$residuals, prob=c(0.25,0.75), na.rm=TRUE)
    iqr <- diff(resid.q)
    limits <- resid.q + sensitivity*iqr*c(-1,1)
    df$isOutlier <- ifelse(df$residuals < limits[1] | df$residuals > limits[2], 1, 0)
    return(df)
}