if (!require('xml2')) install.packages('xml2')
source('scrape_scrape.R')
mycobank <- readRDS('mycobank.RDS')
mycobank$MycoBank__ %>% walk(mb_all)