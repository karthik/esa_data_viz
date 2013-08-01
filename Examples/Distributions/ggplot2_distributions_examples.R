
rm(list=ls())
library(ggplot2)

dt <- rnorm(50, 2, 0.5)
dt2 <- rnorm(50, 3, 0.5)
dt.all <- c(dt, dt2)
sp <- c("SP1", "SP2")
data <- data.frame(species = factor(rep(sp, each = 50)), var1=dt.all)

# The color-blind palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

ggplot(data, aes(x=var1, fill=species)) + 
  geom_density(alpha=0.2) + 
  xlab(expression(beta)) + ylab("posterior density") +
  theme_bw() +
  scale_fill_manual(values=cbPalette) +
  scale_fill_hue(l=40) +
  scale_x_continuous(limits = c(0,4)) +
  theme(axis.title.x = theme_text(size=20),
        axis.title.y = theme_text(size=20, angle=90), 
        axis.text.x = theme_text(size=14), 
        axis.text.y = theme_text(size=14), 
        panel.grid.major = theme_blank(),
        panel.grid.minor = theme_blank()
        #legend.position = c(0.8, 3)
  )

