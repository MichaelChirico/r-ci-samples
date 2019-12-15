#!/bin/bash
TRAVIS=.travis.yml
GH_STEM=https://raw.githubusercontent.com
NOW=$(TZ=UTC date +%Y-%m-%d_%H-%M-%S)

mkdir -p travis-ci

for TRAVIS_REPO in             \
  business-science/tidyquant   \
  christophergandrud/networkD3 \
  cpsievert/LDAvis             \
  daattali/addinslist          \
  daattali/shinyjs             \
  dkahle/ggmap                 \
  dmlc/xgboost                 \
  dreamRs/esquisse             \
  dselivanov/text2vec          \
  facebook/prophet             \
  greta-dev/greta              \
  HenrikBengtsson/future       \
  hms-dbmi/UpSetR              \
  hrbrmstr/ggalt               \
  hrbrmstr/hrbrthemes          \
  hrbrmstr/waffles             \
  igraph/igraph                \
  imbs-hl/ranger               \
  IndrajeetPatil/ggstatsplot   \
  jimhester/lintr              \
  jokergoo/circlize            \
  joshuaulrich/quantmod        \
  jrnold/ggthemes              \
  juliasilge/tidytext          \
  karthik/wesanderson          \
  kassambara/ggpubr            \
  KentonWhite/ProjectTemplate  \
  leeper/rio                   \
  mkearney/rtweet              \
  MilesMcBain/datapasta        \
  mlflow/mlflow                \
  ModelOriented/DALEX          \
  njtierney/naniar             \
  opencpu/opencpu              \
  paul-buerkner/brms           \
  quanteda/quanteda            \
  Rdatatable/data.table        \
  r-lib/devtools               \
  r-lib/httr                   \
  r-lib/pkgdown                \
  r-lib/testthat               \
  r-lib/usethis                \
  r-spatial/sf                 \
  RcppCore/Rcpp                \
  renkun-ken/formattable       \
  rich-iannone/DiagrammeR      \
  robjhyndman/forecast         \
  ropensci/cld2                \
  ropensci/drake               \
  ropensci/plotly              \
  ropensci/skimr               \
  rstudio/blogdown             \
  rstudio/bookdown             \
  rstudio/keras                \
  rstudio/leaflet              \
  rstudio/plumber              \
  rstudio/r2d3                 \
  rstudio/reticulate           \
  rstudio/rmarkdown            \
  rstudio/rticles              \
  rstudio/shiny                \
  rstudio/shinydashboard       \
  rstudio/tensorflow           \
  satijalab/seurat             \
  sfirke/janitor               \
  sinhrks/ggfortify            \
  slowkow/ggrepel              \
  sparklyr/sparklyr            \
  stan-dev/rstan               \
  thomasp85/gganimate          \
  thomasp85/ggforce            \
  thomasp85/lime               \
  tidymodels/infer             \
  tidyverse/broom              \
  tidyverse/dplyr              \
  tidyverse/googlesheets4      \
  tidyverse/ggplot2            \
  tidyverse/glue               \
  tidyverse/lubridate          \
  tidyverse/purrr              \
  tidyverse/readr              \
  tidyverse/readxl             \
  tidyverse/reprex             \
  tidyverse/rvest              \
  tidyverse/tidyverse          \
  tidyverse/tidyr              \
  topepo/caret                 \
  tylermorganwall/rayshader    \
  wesm/feather                 \
  wilkelab/cowplot             \
  xtensor-stack/xtensor        \
  yihui/knitr                  \
  yihui/xaringan               \
  ;
do
  curl -s -o travis-ci/${TRAVIS_REPO##*/}$TRAVIS \
    $GH_STEM/$TRAVIS_REPO/master/$TRAVIS
done

git add . && \
  git commit -m "Update $NOW" && \
  git push origin master
