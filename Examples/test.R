mass.plot <- ggplot(data=scatter_data, aes(x=diameter, y=total_mass)) +
  geom_point(alpha=0.5, size=3, aes(color=spp, shape=spp)) +
  #add linear model fit and 95% CI
  stat_smooth(method="lm", aes(color=spp, shape=spp, fill=spp)) + 
  #set line and point colors
  scale_colour_manual(values = c("black", "darkorange", "steelblue")) + 
  #set fill colors to match
  scale_fill_manual(values = c("black", "darkorange", "steelblue")) + 
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
    #make log-log scale
                labels = trans_format("log10", math_format(10^.x))) + 
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
    #make log-log scale
                labels = trans_format("log10", math_format(10^.x))) + 
  xlab("Diameter (cm)") + ylab("Branch Mass (g)") +
  #add text for panel ID
  geom_text(aes(2,100000,label = "B")) + 
  theme_few() +
  theme(axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14, angle=90), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12)) +
  #removes legend from second plot
  guides(shape=FALSE, color=FALSE, fill=FALSE) 


final.fig <- grid.arrange(length.plot, mass.plot, ncol = 2)
final.fig