library(lubridate)

# Function to produce a df with fitted model from a zoo time-series
harmonFit <- function(x, formula = response ~ trend + harmon, order = 3, fit = TRUE){
    df <- data.frame(dates = index(x),
                     ddates = decimal_date(index(x)),
                     response = as.vector(x))
    df$trend <- as.vector(df$dates - min(df$dates) + 1)
    df$season <- yday(df$dates)
    # Build harmonic regressors (matrix within data.frame)
    harmon <- outer(2 * pi * as.vector(df$ddates), 1:order)
    harmon <- cbind(apply(harmon, 2, cos), apply(harmon, 2, sin))
    colnames(harmon) <- c(paste("cos", 1:order, sep = ""), paste("sin", 1:order, sep = ""))
    # Add matrix of harmonic regressors to df
    df$harmon <- harmon
    if(fit) {
        model <- lm(formula = formula, data = df)
        df$prediction <- predict(model, df)
        df$residuals <- df$response - df$prediction
    }
    return(df)
}
