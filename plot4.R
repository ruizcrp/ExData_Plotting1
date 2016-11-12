
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
png("plot4.png", width=480, height=480)

#for plot4 we will use par with mfcol
par(mfcol=c(2,2))

####Now I insert the code for two of the previous graphs
#this was the code of plot2
plot(data$Date,data$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)")
lines(data$Date,data$Global_active_power)

#and this is the code of plot3
plot(data$Date,data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(data$Date,data$Sub_metering_1)
lines(data$Date,data$Sub_metering_2,col="red")
lines(data$Date,data$Sub_metering_3,col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
col=c("black","red","blue"),lty=1)


#Now two additional graphs are drawn
plot(data$Date,data$Voltage,type="n",ylab="Voltage",xlab="datetime")
lines(data$Date,data$Voltage)

#and the second additional graph
plot(data$Date,data$Global_reactive_power,type="n",ylab="Global_reactive_power",xlab="datetime")
lines(data$Date,data$Global_reactive_power)

dev.off()

