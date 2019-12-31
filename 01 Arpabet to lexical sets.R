
# This script translates vowel labels from Arpabet (used by 
# default in DARLA) to Wells lexical set labels.
# Written by Lars Hinrichs, lh@utexas.edu


# Install (if necessary) and load pacman.
if (!require(pacman)){
  install.packages('pacman')
  }
library(pacman)

# Install needed packages
p_load(tidyverse, plyr)


# !!! Data must be in memory as df. !!!

# Change the labels in the vowels column to Wells lexical set labels.
df$vowel <- mapvalues(df$vowel, 
                      from = c("AA", "AE", "AH", "AO", 
                               "AW", "AY", "EH", "ER", 
                               "EY", "IH", "IY", "OW", 
                               "OY", "UH", "UW"),
                      to = c("LOT/PALM/START", "TRAP/BATH", "STRUT", "THOUGHT", 
                             "MOUTH", "PRICE", "DRESS", "NURSE", 
                             "FACE", "KIT", "FLEECE", "GOAT", 
                             "CHOICE", "FOOT", "GOOSE"))




