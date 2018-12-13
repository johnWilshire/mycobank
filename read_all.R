library(purrr)

#dir(path = 'output', full.names = T) %>% 
#  map_dfr(function(name) readRDS(name)) %>% 
#  saveRDS('mycobank_descriptions.RDS')

readRDS('mycobank_descriptions.RDS') -> mb

library(tidyverse)

mb %>% glimpse

# sapply(mb, function(x) sum(is.na(x)))


mb %>% mutate(
  description_nchar = nchar(description_description_)
) -> mb

mb %>% summarise(n_distinct(base__id)) -> mycobank_ids

ggplot(mb, aes(description_nchar)) + geom_histogram(bins = 500) +
  #scale_x_sqrt() + 
  xlab('Number of characters in the description') + 
  ggtitle(paste(format(n_distinct(mb$base__id), big.mark = ','), 'mycobank Ids'),
          subtitle = paste(format(nrow(mb), big.mark = ','), 'total descriptions')) 
  #theme_()


