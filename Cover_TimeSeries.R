rm(list=ls())

#set working directory
wd = "/Users/atredenn/Documents/Projects/Diversity_Stability/"
setwd(wd)
getwd()

library(plyr)
library(ggplot2)
library(grid)

### Idaho data ###

#read in data from point and polygon files
polydata.id <- read.csv("/Users/atredenn/Documents/Projects/Diversity_Stability/Idaho_Data/Idaho_allrecords_cover.csv")
polydata.id <- as.data.frame(polydata.id)
polydata.id$species <-as.character(polydata.id$species)
species.id <- read.csv("/Users/atredenn/Documents/Projects/Diversity_Stability/Idaho_Data/species_list.csv")
species.id <- as.data.frame(species.id)
species.id$species <- as.character(species.id$species)

#subset the data for columns of interest
data.id <- subset(polydata.id, select=c(quad, year, species, area))

data.id <- data.id[order(data.id$quad, data.id$year),]
names(data.id)

data.id <- data.id[data.id$year != 73,]

#Separate out dominant species, skip this if not interested in just dominant species
dom.spp <- c("Poa secunda",
             "Artemisia tripartita",
             "Hesperostipa comata",
             "Pseudoroegneria spicata")

data.poa <- data.id[data.id$species == dom.spp[1],]
data.art <- data.id[data.id$species == dom.spp[2],]
data.hes <- data.id[data.id$species == dom.spp[3],]
data.pse <- data.id[data.id$species == dom.spp[4],]

data.dom <- rbind(data.poa, data.art, data.hes, data.pse)

data.dom <- data.dom[order(data.dom$quad, data.dom$year),]

df.agg.dom <- ddply(data.dom, .(quad, year, species), summarise,
                    sum = sum(area))
yrs <- sort(unique(df.agg.dom$year))
quads <- sort(unique(df.agg.dom$quad))
dat.all <- data.frame(quad=NA,
                      year=NA,
                      species=NA,
                      sum=NA)
dat.quad <- data.frame(quad=NA,
                       year=NA,
                       species=NA,
                       sum=NA)

#Add in zeros (0) for quads that have no record of a dominant species
for(i in 1:length(quads)){
  dat.quad <- df.agg.dom[df.agg.dom$quad == quads[i],]
  for (j in 1:length(yrs)){
    dat.quadyr <- dat.quad[dat.quad$year == yrs[j],]
    for (k in 1:length(dom.spp)){
      ifelse (length(grep(dom.spp[k], dat.quadyr$species)) == 0,
              dat.quadyr <- rbind(dat.quadyr, data.frame(quad = quads[i],
                                                         year = yrs[j],
                                                         species = dom.spp[k],
                                                         sum = 0)),
              dat.quadyr <- dat.quadyr)
    }
    dat.quad <- rbind(dat.quad, dat.quadyr)
  }
  dat.all <- rbind(dat.all, dat.quad)
}

df.agg.dom <- dat.all[2:nrow(dat.all),]
q1.df <- ddply(df.agg.dom, .(year, species), summarise, 
               avg = mean(sum))


df.agg.domtot <- ddply(data.dom, .(quad, year), summarise,
                       sum = sum(area))
df.agg.domavg <- ddply(df.agg.domtot, .(year), summarise,
                       tot = (mean(sum)*100))

##Plot dominant species average cover through time
ggplot(data=q1.df, aes(x=year, y=(avg*100))) + 
  geom_line(aes(linetype=species), color="grey45") +
  geom_point(aes(shape=species), color="white", size=3) +
  geom_point(aes(shape=species), size=2) + 
  theme_bw() +
  xlab("Year (19xx)") + ylab("Mean Cover (%)") +
  theme(axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14, angle=90), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = c(0.25,0.85),
        legend.title = element_blank(),
        legend.key = element_blank(),
        legend.text=element_text(size=8, face="italic"),
        legend.background = element_rect(colour = NA),
        legend.key.height = unit(1, "mm")
  ) 
