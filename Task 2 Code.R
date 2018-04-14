Panel_8595 <- read.table("~/Desktop/Panel_8595.Txt",skip=2)
View(Panel_8595)
colnames <- c("x","x.1","x.2","x.3","x.4","x.5","x.6","x.7","x.8","x.9","x.10","x.11","x.12")
colnames(Panel_8595) <- colnames 
Panel_8595$x.1 = NULL
colnames(Panel_8595)[colnames(Panel_8595)=="x"] <- "plant"
colnames(Panel_8595)[colnames(Panel_8595)=="x.2"] <- "year"
means <- Panel_8595 %>% group_by(year) %>% summarise_all(funs(mean))
means1 <- subset(means, year==87 | year==95)
colnames(Panel_8595)[colnames(Panel_8595)=="x.3"] <- "Electricity"
colnames(Panel_8595)[colnames(Panel_8595)=="x.4"] <- "SO2"
colnames(Panel_8595)[colnames(Panel_8595)=="x.5"] <- "NOx"
colnames(Panel_8595)[colnames(Panel_8595)=="x.6"] <- "Capital_Stock"
colnames(Panel_8595)[colnames(Panel_8595)=="x.7"] <- "Employees"
colnames(Panel_8595)[colnames(Panel_8595)=="x.8"] <- "Heat_coal"
colnames(Panel_8595)[colnames(Panel_8595)=="x.9"] <- "Heat_oil"
colnames(Panel_8595)[colnames(Panel_8595)=="x.10"] <- "Heat_gas"
Panel_8595$x.11 = NULL
Panel_8595$x.12 = NULL
Panel_8595.1 <- Panel_8595
Panel_8595.1$Heat_coal <- (Panel_8595$Heat_coal*0.00000029)/365
Panel_8595.1$Heat_oil <- (Panel_8595$Heat_oil*0.00000029)/365
Panel_8595.1$Heat_gas <- (Panel_8595$Heat_gas*0.00000029)/365
Panel_8595.1$Electricity <- (Panel_8595$Electricity*0.001)/365
Panel_8595.1$SO2 <- (Panel_8595$SO2)/365
Panel_8595.1$NOx <- (Panel_8595$NOx)/365
Panel_8595.1$Capital_Stock <-(Panel_8595$Capital_Stock*4.513)
Panel_8595.1$CAAP1 <- as.numeric(Panel_8595$year>=90)
write.table(Panel_8595.1, "tidy2.txt", row.names=F, col.names=T, sep="\t", quote=F)
Panel_8595.2a <- Panel_8595.1 %>% group_by(plant) %>% summarise_all(funs(mean))
Panel_8595.2b <- Panel_8595.1 %>% group_by(year) %>% summarise_all(funs(sum))
write.table(Panel_8595.2a, "tidy2_a.txt", row.names=F, col.names=T, sep="\t", quote=F)
write.table(Panel_8595.2b, "tidy2_b.txt", row.names=F, col.names=T, sep="\t", quote=F)