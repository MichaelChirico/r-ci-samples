repos = readLines('.tracked_repos')

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

sapply(names(known_meta), dir.create, showWarnings = FALSE)

GH_STEM = 'https://github.com'
for (repo in repos) {
  cat('Cloning ', repo, '...\n', sep = '')
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
  unlink('tmp', recursive = TRUE, force = TRUE)
}
