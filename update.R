repos = readLines('.tracked_repos')

known_meta = c(
  travis = '.travis.yml',
  gitignore = '.gitignore',
  rbuildignore = '.Rbuildignore',
  appveyor = '.appveyor.yml',
  'gitlab-ci' = '.gitlab-ci.yml',
  pkgdown = '_pkgdown.yml',
  make = 'Makefile',
  rproj = '.Rproj',
  jenkins = 'Jenkinsfile'
)

sapply(names(known_meta), dir.create, showWarnings = FALSE)

GH_STEM = 'https://github.com'
RAW_STEM = 'https://raw.githubusercontent.com'
for (repo in repos) {
  cat('Scraping ', repo, '...\n', sep = '')
  svn_cmd = sprintf('svn ls -R %s/%s.git/branches/master', GH_STEM, repo)
  files = system(svn_cmd, intern = TRUE)
  for (ii in seq_along(known_meta)) {
    meta = known_meta[ii]
    if (length(idx <- grep(meta, files, fixed = TRUE))) {
      cat('\t✅ Found', meta, '\n')
      curl_cmd = sprintf(
        'curl -s -o %s/%s%s %s/%s/master/%s',
        names(meta), paste0(basename(repo), if (grepl('^[^._]', meta)) '-'),
        meta, RAW_STEM, repo, files[idx]
      )
      system(curl_cmd)
    }
  }
}
