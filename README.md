# 

```{bash}
# pull docker image
docker pull rocker/tidyverse
# clone repo
git clone https://github.com/johnWilshire/mycobank
# run 
docker run -d -e ROOT=TRUE -v `pwd`:/mycobank  rocker/tidyverse /bin/bash -c "cd mycobank && Rscript run.R"
```

