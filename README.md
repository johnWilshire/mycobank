# 

```{bash}
# pull docker image
docker pull rocker/tidyverse
# clone repo
git clone https://github.com/johnWilshire/mycobank
# run 
docker run -d --name mycoscraper -v `pwd`:/mycobank  rocker/tidyverse cd mycobank; Rscript run.R
```

