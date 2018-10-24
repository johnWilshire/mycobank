#library(openxlsx)
#read.xlsx('~/Desktop/Export.xlsx') -> export
#smol <- head(export)

library(xml2)
library(tidyverse, verbose = F, quietly = T)
#smol$Link.to.the.MycoBank.website

# MBWService basic from mb id
mb_id_to_basic <- function (id = 282572) {
  url <- paste0('http://www.mycobank.org/Services/Generic/SearchService.svc/rest/xml?layout=14682616000003562&filter=mycobanknr_=%22',id,'%22')
  read_xml(url)
}



mb_extract_description_ids <- function(basic_xmls) basic_xmls %>%
  xml_find_all('.//description_pt_') %>% 
  xml_text() %>% 
  str_extract_all(pattern = '<Id>\\d+</Id>', simplify = T) %>% 
  str_remove_all('[^\\d]') %>% 
  as.numeric()

mb_desc_id_to_desc <- function (desc_id) {
  url <- paste0('http://www.mycobank.org/Services/Generic/SearchService.svc/rest/xml?layout=14682616000000209&filter=_id=%22',desc_id,'%22')
  read_xml(url)
}


mb_extract_taxon <- function (desc) {
  desc %>% xml_find_all('.//Taxon') %>% as_list %>% 
  flatten() %>% flatten %>% as_tibble()
}


mb_all <- function(mb_id, wait = 0.2) {
  Sys.sleep(wait)
  tryCatch({
    print(mb_id)
    basic <- mb_id_to_basic(mb_id)
    basic_df <- basic %>% mb_extract_taxon
    # print(basic_df %>% glimpse)
    ids <- basic %>%  mb_extract_description_ids
    # print(ids)
    ids_dfs <- ids %>% map_df(function(id) {
      Sys.sleep(wait)
      mb_desc_id_to_desc(id) %>% mb_extract_taxon
    })
    colnames(basic_df) <- paste0('base_',colnames(basic_df))
    colnames(ids_dfs) <- paste0('description_',colnames(ids_dfs))
    saveRDS(cbind(basic_df, ids_dfs), paste0('output/',mb_id,'.RDS'))
  }, error = function(e) {
    system(paste('echo', mb_id, '>> fail_ids.txt'))
  })
}


