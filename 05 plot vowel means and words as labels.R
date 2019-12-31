# This script reads a data sheet containing vowels for
# multiple speakers and creates one plot of their vowel
# means per individual. Each speaker's word tokens are shown in
# the background as labels.
# Written by Lars Hinrichs, lh@utexas.edu


# Install (if necessary) and load pacman.
if (!require(pacman)){
  install.packages('pacman')
  }
library(pacman)


# load needed packages
p_load(rio, tidyverse, ggthemes, ggrepel, plyr, scales)


## import the data frame
df <- import("data_two_speakers.csv")


## have the column "vowel" translated to lexical
## set labels
df$vowel <- mapvalues(df$vowel, 
                      from = c("AA", "AE", "AH", "AO", 
                               "AW", "AY", "EH", "ER", 
                               "EY", "IH", "IY", "OW", 
                               "OY", "UH", "UW"),
                      to = c("LOT/PALM/START", "TRAP/BATH", "STRUT", "THOUGHT", 
                             "MOUTH", "PRICE", "DRESS", "NURSE", 
                             "FACE", "KIT", "FLEECE", "GOAT", 
                             "CHOICE", "FOOT", "GOOSE"))


# calculate vowel means
df_mean <- df %>%
  group_by(name, vowel) %>%
  summarise_if(is.numeric, mean)


## make a plot using ggplot that includes two 
## separate panels, one for each speaker. to do this 
## you'll need to break up the data by speaker using
## the "facet_wrap()" function. it is added as the 
## last layer at the end of the code that makes 
## the plot: + facet_wrap(~speaker, scales = "free").

p <- 
  ggplot(data = df, aes(x=F2, y=F1)) +
  scale_x_reverse(name="F2 (Hz)") + 
  scale_y_reverse(name="F1 (Hz)") +  
  geom_text(aes(label = word),
            size = 1.5, 
            color = "blue",
            alpha = 0.3
            ) +
  geom_label_repel(data = df_mean,
    aes(label=vowel),
    color="black",
    size = 3.2) +
  geom_point(data = df_mean,
    size=2.9, color="grey20") +
  facet_wrap(~name, scales = "free") +
  scale_fill_grey() +
  ggtitle("xxx",
          subtitle="xxx") +
  theme_bw() +
  labs(caption = "xxx")

p


## save the plot as a file with ggsave().
ggsave("xxx filename xxx.png",
       width = 8,
       height = 4,
       units = "in"
       )


