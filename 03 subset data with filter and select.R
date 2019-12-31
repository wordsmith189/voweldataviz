## Try sourcing this script. It should create new data sheets
## and graphic files in your project folder. 
## ('data_two_speakers.csv' needs to be in project folder.)
## Written by Lars Hinrichs, lh@utexas.edu


# Install (if necessary) and load pacman.
if (!require(pacman)){
  install.packages('pacman')
  }
library(pacman)

# install/load rio, tidyverse, ggthemes, ggrepel 
# using p_load()
p_load(rio, tidyverse, plyr)


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

## With the function filter(), we can select certain ROWS by
## whatever criteria we give in the argument to the function.
## With the function select(), we can select certain COLUMNS
## according to the criteria we mention, or - as below - just
## by the names of the columns that we want to keep.

# Select only the rows for a certain speaker, keeping only 
# those columns that we're going to work with. 
df_chris <- df %>% 
  select(name, 
         word, 
         vowel, 
         F1_LobanovNormed_unscaled, 
         F2_LobanovNormed_unscaled) %>% 
  filter(name == "Chris")

# Save this new, smaller dataset as a spreadsheet.
export(df_chris, "data_chris.csv")

# Repeat: now we'll filter out another speaker and select the
# same set of columns as before.
df_efren <- df %>% 
  select(name, 
         word, 
         vowel, 
         F1_LobanovNormed_unscaled, 
         F2_LobanovNormed_unscaled) %>% 
  filter(name == "Efren")

# As before: save this new, smaller dataset as a spreadsheet.
export(df_efren, "data_efren.csv")



## 4. Create separate single-speaker plots based on these
## two new data frames you have created in step 3. (You
## can use the plotting code from today's first practice
## script, leaving out the facet_wrap().) Use ggsave() 
## both of your plot commands to save the plots as files.

# plot for the first speaker
p_chris <- 
  ggplot(data = df_chris, 
         aes(x=F2_LobanovNormed_unscaled,
             y=F1_LobanovNormed_unscaled)) +
  scale_x_reverse(name="F2 (Lobanov)") + 
  scale_y_reverse(name="F1 (Lobanov)") +  
  geom_label(aes(label = word, color = vowel),
             size = 2.5, 
             alpha = 0.7
  ) +
  ggtitle("xxx mAiN TiTlE xx",
          subtitle="xxx suBtItLe xX") +
  theme_bw() +
  labs(caption = "xxx optional caption")

p_chris

ggsave("xx filename chris xx.png", width=7, height=4.5, units="in")



# plot for the second speaker 

p_efren <- 
  ggplot(data = df_efren, 
         aes(x=F2_LobanovNormed_unscaled,
             y=F1_LobanovNormed_unscaled)) +
  scale_x_reverse(name="F2 (Lobanov)") + 
  scale_y_reverse(name="F1 (Lobanov)") +  
  geom_label(aes(label = word, color = vowel),
            size = 2.5, 
            alpha = 0.7
  ) +
  ggtitle("xxx mAiN TiTlE xx",
          subtitle="xxx suBtItLe xX") +
  theme_bw() +
  labs(caption = "xxx optional caption")

p_efren

ggsave("xx filename efren xx.png", width=7, height=4.5, units="in")


