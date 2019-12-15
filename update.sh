#!/bin/bash
NOW=$(TZ=UTC date +%Y-%m-%d_%H-%M-%S)

Rscript update.R

git add . && \
  git commit -m "Update $NOW" && \
  git push origin master
