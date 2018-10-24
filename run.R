source('scrape_scrape.R')
mycobank <- readRDS('mycobank.RDS')
mycobank$MycoBank__ %>% walk(mb_all)