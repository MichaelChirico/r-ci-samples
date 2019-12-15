source("find_store_github_actions.R", encoding = "UTF-8")

repos = readLines('.tracked_repos')

# file patterns; e.g. appveyor can be .appveyor.yml or appveyor.yml
known_meta = c(
  travis = '.travis.yml',
  gitignore = '.gitignore',
  rbuildignore = '.Rbuildignore',
  appveyor = 'appveyor.yml',
  'gitlab-ci' = '.gitlab-ci.yml',
  pkgdown = '_pkgdown.yml',
  make = 'Makefile',
  rproj = '.Rproj',
  jenkins = 'Jenkinsfile',
  codecov = 'codecov.yml'
)

invisible(sapply(names(known_meta), dir.create, showWarnings = FALSE))

GH_STEM = 'https://github.com'
# approach: clone the most recent commit of the repo, then
#   examine the directory structure for each target meta file.
#   Main drawback I see so far is in the file[1L] part -- it would be
#   ideal to get the _right_ file rather than just the first one,
#   but I haven't seen a way to do this scalably yet.
# alternative approaches skipped [both are in commit history]:
#   - Simply record manually which files are in which repo; this is what I did
#     for the initial pass of including travis-ci files, but doing so for
#     a full range of metadata files was too tedious. Besides the sunk time,
#     (1) it becomes a perpetual burden to track when files add/remove CI
#     options and (2) the cut-and-paste approach is suited to package-only
#     repos; e.g., wesm/feather is a higher-level repo of which the R package
#     is only one component, meaning the paths for R-specific files will be
#     different than the paths for meta files, causing havoc for this approach
#   - Use combination of svn ls (to show the file structure of each repo) and
#     curl to pull only specific files. In principle this approach should be
#     much preferred and much faster since I only download a very small number
#     of files relatively, but in practice it was excruciatingly slow. I think
#     there are some throttles set up on these gateways to GitHub that don't
#     appear to affect the git clone API. Also, noteable that the svn ls
#     command appears to be quite fragile for this purpose, failing often
for (repo in repos) {
  cat('Cloning ', repo, '...\n', sep = '')
  # clone to tmp then delete it afterwards
  git_cmd = sprintf('git clone %s/%s.git --depth 1 tmp --quiet', GH_STEM, repo)
  system(git_cmd)
  files = list.files('tmp', recursive = TRUE, all.files = TRUE)
  for (ii in seq_along(known_meta)) {
    meta = known_meta[ii]
    if (length(file <- grep(meta, files, fixed = TRUE, value = TRUE))) {
      cat('\t✅ Found', meta, '\n')
      out_file = paste0(basename(repo), if (grepl('^[^._]', meta)) '-', meta)
      file.rename(file.path('tmp', file[1L]), file.path(names(meta), out_file))
    }
  }
  # find github actions workflows
  find_store_github_actions(repo)
  unlink('tmp', recursive = TRUE, force = TRUE)
}
