# r-ci-samples

Sample Continuous Integration (CI) scripts from popular R package repos

The following package CI tools are tracked:

 - [Travis CI](https://travis-ci.org/) : [`travis`](./travis/)
 - [Appveyor](https://www.appveyor.com/) : [`appveyor`](./appveyor/)
 - [Jenkins](https://jenkins.io/) : [`jenkins`](./jenkins/)
 - [Gitlab CI](https://docs.gitlab.com/ee/ci/) : [`gitlab-ci`](./gitlab-ci/)
 - [Github Actions](https://github.com/features/actions): [`github-actions`](./github-actions/)
 
Also tracked are some common package metadata files:

 - [.gitignore](https://git-scm.com/docs/gitignore) : [`gitignore`](./gitignore/)
 - [GNU Make/`Makefile`](https://www.gnu.org/software/make/) : [`make`](./make/)
 - [`_pkgdown.yml` for `pkgdown` sites](https://pkgdown.r-lib.org/index.html) : [`pkgdown`](./pkgdown/)
 - [`.Rbuildignore`](http://r-pkgs.had.co.nz/package.html) : [`rbuildignore`](./rbuildignore/)
 - [`.Rproj` RStudio project file](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) : [`rproj`](./rproj/)

If you're looking to build CI integration for your R project, look no further!

Build on the backs of R giants & learn from their own existing CI pipelines.

The repos used here are found in the [`.tracked_repos`](./.tracked_repos) file; please file a PR to add any new package.

If there's some CI tool/metadata I'm missing, this can easily be added to the [`update.R`](./update.R) script.

This is updated weekly with Github Actions, see [`.github`](./.github/)
