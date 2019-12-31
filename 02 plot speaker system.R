# This script can be used to plot a single speaker's vowel 
# system. Remember to provide labels and names wherever
# there is a xxx placeholder.
# Written by Lars Hinrichs, lh@utexas.edu


# load pacman to manage all other package loading
if (!require(pacman)){
  install.packages(pacman)
  }
  library(pacman)

# load other packages
p_load(tidyverse, rio, plyr, scales)

# read in the data file as df
df <- import("formants_efren.csv")

# Get rid of NURSE vowels
df <- df %>%  
  filter(vowel != "NURSE")

# convert character columns to factors
df <- df %>% mutate_if(is.character, as.factor)

# calculate means
df <- df %>%
  group_by(vowel) %>%
  summarise_if(is.numeric, mean)


########################################
# PLOT VOWELS

# define the plot as p

p <- 
  ggplot(data = df, aes(x=F2, y=F1)) +
  scale_x_reverse(name="F2 (Hz)") + 
  scale_y_reverse(name="F1 (Hz)") +  
  # expand_limits(x = 2400, y=725) +
  geom_label(
    aes(label=vowel),
    color="black",
    size = 2.1) +
  geom_point(size=2.9, color="grey20") +
  scale_fill_grey() +
  ggtitle("xxx title xxx",
          subtitle="xxx subtitle xxx.") +
  theme_bw() +
  labs(caption = "xxx caption")

p

# set file name
# plot will be saved in PDF format in your project space
ggsave("xx.pdf", device="pdf", width=7, height=6)


