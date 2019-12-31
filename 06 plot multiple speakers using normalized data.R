# This script plots multiple speakers' vowel systems. Their
# vowel data must be included in the same data sheet. It 
# visualizes the Lobanov-normalized data and uses fixed scales,
# therefore it is best suited for direct comparisons among 
# speakers (even across genders).
# Written by Lars Hinrichs, lh@utexas.edu


# Install (if necessary) and load pacman.
if (!require(pacman)){
  install.packages('pacman')
  }
library(pacman)

# load needed packages
p_load(rio, tidyverse, ggthemes, ggrepel, plyr, scales)

# import the data and name it df
df <- import("data_two_speakers.csv")


# have the column "vowel" translated to lexical
# set labels
df$vowel <- mapvalues(df$vowel, 
                      from = c("AA", "AE", "AH", "AO", 
                               "AW", "AY", "EH", "ER", 
                               "EY", "IH", "IY", "OW", 
                               "OY", "UH", "UW"),
                      to = c("LOT/PALM/START", "TRAP/BATH", "STRUT", "THOUGHT", 
                             "MOUTH", "PRICE", "DRESS", "NURSE", 
                             "FACE", "KIT", "FLEECE", "GOAT", 
                             "CHOICE", "FOOT", "GOOSE"))


# calculate means and store in new/sep. data frame
df_mean <- df %>%
  group_by(name, vowel) %>%
  summarise_if(is.numeric, mean)


# make a plot using ggplot that includes two 
# separate panels, one for each speaker. to do this 
# you'll need to break up the data by speaker using
# the "facet_wrap()" function. it is added as the 
# last layer at the end of the code that makes 
# the plot: + facet_wrap(~speaker, scales = "free")
# remember to use ggrepel() for the vowel class 
# labels. 

p <- 
  ggplot(data = df, aes(x=F2_LobanovNormed_unscaled, y=F1_LobanovNormed_unscaled)) +
  scale_x_reverse(name="F2 (Lobanov)") + 
  scale_y_reverse(name="F1 (Lobanov)") +  
  geom_text(aes(label = word),
            size = 1.9, 
            color = "darkred",
            alpha = 0.6
            ) +
  geom_label_repel(data = df_mean,
    aes(label=vowel),
    color="black",
    size = 3.2) +
  geom_point(data = df_mean,
    size=2.9, color="grey20") +
  facet_wrap(~name, 
             # scales = "free"
             ) +
  ggtitle("xxx MaIn TiTlE",
          subtitle="xxx subtitle") +
  theme_bw() +
  labs(caption = "xxx optional caption xxx")

p


# save the plot as a graphic file.
ggsave("xxx filename xxx.png",
       width = 8,
       height = 4,
       units = "in"
       )
