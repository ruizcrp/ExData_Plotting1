

#######THE FIRST PART LOADS THE DATA AGAIN EXACTLY AS IN PLOT1.R#####
#There are many possibilities to load in the data
#I surely did not do the most elegant one but it works
#I load in the entire data first
data<- read.csv("household_power_consumption.txt",header=TRUE,sep = ";",dec=".",
na.strings="?")

#I create a new char-vector merging the two date/time cols
#I can safely owerwrite "data$Date" as I'm gonna delete both cols
data$Date <- paste(data$Date," ", data$Time,sep="")
#deleting also data$Time just to make it clean
data<-data[-2]
#and then I convert it to a date format
data$Date<- strptime(data$Date, format = "%d/%m/%Y %H:%M:%S") 

#Now the data will be limited to the two observed days
data<- data[data$Date < as.POSIXct('2007-02-03 0:00') & data$Date >= as.POSIXct('2007-02-01 0:00') ,]

###################UNTIL HERE IT IS EXACTLY AS IN PLOT1.R###########

#loading the png-device
png("plot2.png", width=480, height=480)
#First the plot is prepared but the lines not drawn with type="n"
plot(data$Date,data$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)")
#now the lines are nicely added
lines(data$Date,data$Global_active_power)

dev.off()