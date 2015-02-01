# Get data, if no header = TRUE, will insert default header, original header goes to row 1
proj1 <- read.table("household_power_consumption.txt", sep=";", header = TRUE)

# Note: Had run tests on small subset proj1test <- proj1[c(1:100,500000:500050),]

# Did following to convert each column from factor to character. Would later combine 
# the first two columns (time and date) into a proper date format, and 
# the rest into numeric   

# Kept the original data untouched in case there is a read to reconfigure later
sandbox <- as.data.frame(proj1)

# Change each column to character type
for (i in 1:ncol(sandbox) ){sandbox[,i]<-as.character(sandbox[,i]) } 

# combine time and date into one column 
sandbox[,1] <- as.POSIXct(paste(sandbox[,1], sandbox[,2]), format="%d/%m/%Y %H:%M:%S") 

# Sort rows by column 1 (date column)
sandbox.sort <- sandbox[ order(sandbox[,1] , decreasing = TRUE ),] 

# Get rows from 2007-02-01 and 2007-02-02 - 
sandbox48 <- sandbox.sort[sandbox.sort[,1] < "2007-02-03 00:00:00 EST" & sandbox.sort[,1] > "2007-01-31 23:59:59 EST",] 

# Delete redundant second column
sandbox48 <- sandbox48[,-2] 

# Create temp data .frame
sandbox48num <- sandbox48

# change columns i=2:8 to numeric 
for (i in 2:ncol(sandbox48)) { sandbox48num[,i] <- as.numeric(sandbox48[,i])} 


# Full plot #2 (with suppressed x-axis)
par(mfrow=c(1,1)) # Ensure full sized graphic
png(file = "plot2.png", width = 480, height = 480) # Open PNG device to place output in working directory

plot(sandbox48num$Date,sandbox48num$Global_active_power,"l", xlab = "", ylab = "Global Active Power (kilowatts)") 
dev.off() # Close the PNG device
