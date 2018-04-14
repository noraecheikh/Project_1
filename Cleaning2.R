#upload the text file into R as a dataframe, using read.table()
Panel_8595 <- read.table("~/Desktop/Panel_8595.Txt",skip=2)

#upload necessary packages
library(dplyr)

#rename the columns of the dataframe, Panel_8595
colnames <- c("x","x.1","x.2","x.3","x.4","x.5","x.6","x.7","x.8","x.9","x.10","x.11","x.12")
colnames(Panel_8595) <- colnames 

#remove unnecessary columns
Panel_8595$x.1 = NULL

#rename the first two columns, "plant" and "year" respectively
colnames(Panel_8595)[colnames(Panel_8595)=="x"] <- "plant"
colnames(Panel_8595)[colnames(Panel_8595)=="x.2"] <- "year"

#create a dataframe, called means, that provides the average for all of the variables, grouped by mean
means <- Panel_8595 %>% group_by(year) %>% summarise_all(funs(mean))

#create another dataframe, called means1, that is a subset of means, which only includes the years 87 and 95
means1 <- subset(means, year==87 | year==95)

#rename the column names, x.3 to x.10, based on the corresponding averages from years 87 and 95 given in the research paper.
colnames(Panel_8595)[colnames(Panel_8595)=="x.3"] <- "Electricity"
colnames(Panel_8595)[colnames(Panel_8595)=="x.4"] <- "SO2"
colnames(Panel_8595)[colnames(Panel_8595)=="x.5"] <- "NOx"
colnames(Panel_8595)[colnames(Panel_8595)=="x.6"] <- "Capital_Stock"
colnames(Panel_8595)[colnames(Panel_8595)=="x.7"] <- "Employees"
colnames(Panel_8595)[colnames(Panel_8595)=="x.8"] <- "Heat_coal"
colnames(Panel_8595)[colnames(Panel_8595)=="x.9"] <- "Heat_oil"
colnames(Panel_8595)[colnames(Panel_8595)=="x.10"] <- "Heat_gas"

#remove unnecessary columns
Panel_8595$x.11 = NULL
Panel_8595$x.12 = NULL

#create a new dataframe of Panel_8595, called Panel_8595.1
Panel_8595.1 <- Panel_8595

#convert the energy measurements of Heat_coal,Heat_oil, Heat_gas, and Electricity into Mwh and daily averages
Panel_8595.1$Heat_coal <- (Panel_8595$Heat_coal*0.00000029)/365
Panel_8595.1$Heat_oil <- (Panel_8595$Heat_oil*0.00000029)/365
Panel_8595.1$Heat_gas <- (Panel_8595$Heat_gas*0.00000029)/365
Panel_8595.1$Electricity <- (Panel_8595$Electricity*0.001)/365

#convert the pollutant qualities of SO2 and NOx into daily averages
Panel_8595.1$SO2 <- (Panel_8595$SO2)/365
Panel_8595.1$NOx <- (Panel_8595$NOx)/365

#convert the Capital_Stock from 1973 US dollars to 2017 US dollars
Panel_8595.1$Capital_Stock <-(Panel_8595$Capital_Stock*4.513)

#create a binary variable which indicates if the Clean Air Act Phase I restrictions had been announced yet (1=yes, 0=no)
Panel_8595.1$CAAP1 <- as.numeric(Panel_8595$year>=90)

#save the tidy set as "tidy2.txt"
write.table(Panel_8595.1, "tidy2.txt", row.names=F, col.names=T, sep="\t", quote=F)

#create a subset of Panel_8595.1 which averages all of the variables across all years for each plant for the 11 year period, called Panel_8595.2a
Panel_8595.2a <- Panel_8595.1 %>% group_by(plant) %>% summarise_all(funs(mean))

#save the tidy set as "tidy2_a.txt"
write.table(Panel_8595.2a, "tidy2_a.txt", row.names=F, col.names=T, sep="\t", quote=F)

#create a subset of Panel_8595.1 which adds all of the variables within a particular year across all 92 plants, called Panel_8595.2b
Panel_8595.2b <- Panel_8595.1 %>% group_by(year) %>% summarise_all(funs(sum))

#save the tidy set as "tidy2_b.txt"
write.table(Panel_8595.2b, "tidy2_b.txt", row.names=F, col.names=T, sep="\t", quote=F)