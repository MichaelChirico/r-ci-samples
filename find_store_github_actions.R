find_store_github_actions <- function(repo,
                                      github_pattern = "\\.github.*workflows.*(yml|yaml)",
                                      github_folder_name = "github_actions") {

  if (!dir.exists(github_folder_name)) {
    invisible(dir.create(github_folder_name, showWarnings = FALSE))
  }

  files = list.files('tmp', recursive = TRUE, all.files = TRUE)

  if (length(files_found <- grep(github_pattern, files, value = TRUE))) {
    cat('\t Found .github \n')
    invisible(dir.create(file.path(github_folder_name, basename(repo)), showWarnings = FALSE))
    for (file in files_found) {
      out_file = file.path(github_folder_name, basename(repo), basename(file))
      file.rename(file.path('tmp', file[1L]), out_file)
    }
  }
}