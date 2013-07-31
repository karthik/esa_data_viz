##Example for making x-y scatterplot with linear model fits in ggplot2##

#Depends: ggplot2, gridExtra, grid, ggthemes

#Data from Tredennick et al. 2013, 
#accessed from Dryad (http://datadryad.org/resource/doi:10.5061/dryad.4s1d2)

rm(list=ls())

require(ggplot2)
require(gridExtra)
require(grid)
require(ggthemes)
require(scales)

#Set data file path
data.file <- "/Users/atredenn/Documents/Projects/SSDE-Project/R_Code/Allometry_2010_Mali/FINAL/AllometryData_noPTSU_Indexed.csv"
#read in data
data <- read.csv(data.file)
names(data) <- tolower(names(data)) #change col names to lower case
data = data[data$aggregated_leaf_wt>-9000,] #take out bad data

data <- as.data.frame(data) #make it a data frame
head(data) #look at first lines

#Make a plot of diameter vs. length
length.plot <- ggplot(data=data, aes(x=diameter, y=length)) +
  geom_point(alpha=0.5, size=3, aes(color=spp, shape=spp)) +
  stat_smooth(method="lm", aes(color=spp, shape=spp, fill=spp)) + #add linear model fit and 95% CI
  scale_colour_manual(values = c("black", "darkorange", "steelblue")) + #set line and point colors
  scale_fill_manual(values = c("black", "darkorange", "steelblue")) + #set fill colors to match
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + #make log-log scale
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + #make log-log scale
  xlab("Diameter (cm)") + ylab("Branch Length (cm)") +
  geom_text(aes(2,2000,label = "A")) + #add text for panel ID
  theme_few() +
  theme(axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14, angle=90), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12), 
        legend.position = c(0.72,0.2),
        legend.title = element_blank(),
        legend.key = element_blank(),
        legend.text=element_text(size=10, face="italic"),
        legend.background = element_rect(colour = NA),
        legend.key.height = unit(5, "mm")
  ) 

#make a plot of diameter vs. mass
mass.plot <- ggplot(data=data, aes(x=diameter, y=total_mass)) +
  geom_point(alpha=0.5, size=3, aes(color=spp, shape=spp)) +
  stat_smooth(method="lm", aes(color=spp, shape=spp, fill=spp)) + #add linear model fit and 95% CI
  scale_colour_manual(values = c("black", "darkorange", "steelblue")) + #set line and point colors
  scale_fill_manual(values = c("black", "darkorange", "steelblue")) + #set fill colors to match
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + #make log-log scale
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + #make log-log scale
  xlab("Diameter (cm)") + ylab("Branch Mass (g)") +
  geom_text(aes(2,100000,label = "B")) + #add text for panel ID
  theme_few() +
  theme(axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14, angle=90), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12)) +
  guides(shape=FALSE, color=FALSE, fill=FALSE) #removes legend from second plot

#call for PDF function to save the plots
pdf(file="/users/atredenn/desktop/allom_fig.pdf", width=10, height=4)
#arrange the two plots side-by-side
final.fig <- grid.arrange(length.plot, mass.plot, ncol=2)
dev.off() #turn off plotting device

