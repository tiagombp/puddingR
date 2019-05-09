#' @title Create New Pudding Project
#' @description Creates a new R project and generates the folders needed for consistent Pudding analysis
#' @param name File name for the project. Default: "analysis"
#' @param title What the project does, one line, title case, Default: NULL
#' @param folder Folder under which to create the new project, Default: getwd()
#' @param dirs Character vector of new directories to create, Default: c("assets", "functions", "open_data", "plots", "processed_data",
#'    "raw_data", "reports", "rmds", "rscripts")
#' @param packagedeps Set which tool you would like to use for package reproducibility, Default: 'packrat'
#' @param reset Whether to reset the active project to your new project, Default: TRUE
#' @param open Whether the new project should open automatically, Default: TRUE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' folder <- tempdir()
#' createProject(
#'   name = "pudding-analysis", title = "My Next Great Story",
#'   folder = folder,
#'   packagedeps = "checkpoint",
#'   reset = TRUE,
#'   open = FALSE
#' )
#' list.files(file.path(folder, "pudding-analysis"))
#' unlink(file.path(folder, "pudding-analysis"))
#' }
#' @seealso
#'  \code{\link[usethis]{create_package}},\code{\link[usethis]{proj_utils}},\code{\link[usethis]{use_description}}
#'  \code{\link[rstudioapi]{isAvailable}},\code{\link[rstudioapi]{projects}}
#'  \code{\link[desc]{desc_set}}
#' @rdname createProject
#' @export
#' @importFrom usethis create_project proj_set use_description proj_get
#' @importFrom rstudioapi isAvailable openProject
#' @importFrom desc desc_set
createProject <- function(name = "analysis", title = NULL,
                          folder = getwd(),
                          dirs = c("assets", "functions", "open_data", "plots", "processed_data", "raw_data", "reports", "rmds", "rscripts"),
                          packagedeps = "packrat",
                          reset = TRUE,
                          open = TRUE){
  # basic checks for missing information
  if (missing(name)) stop("oops! you need a name for your project")
  if (!is.character(name)) stop("name has to be a character")
  if (nchar(name) < 2) stop("name needs to have at least two characters")

  # check if the requested package dependency is accepted
  packagedeps <- match.arg(packagedeps, okpackagedeps())

  # for later resetting the project
  current <- getCurrentProj()

  tryCatch({

    # create the project
    usethis::create_project(file.path(folder, name),
                            # don't open yet regardless of argument
                            open = FALSE,
                            # use R Studio if it's available
                            rstudio = rstudioapi::isAvailable())

    # set the current project to the new one
    usethis::proj_set(file.path(folder, name),
                      force = TRUE)

    # add DESCRIPTION file and full title
    usethis::use_description()
    desc::desc_set("Title", title,
                   file = usethis::proj_get())

    # setup system for dependencies management
    setup_dep_system(packagedeps)
  },
  error = function(e){
    message(paste("Error:", e$message))
    e
    # delete folder created earlier
    unlink(file.path(folder, name), recursive = TRUE)
    message(sprintf("Oops! An error was found and the `%s` directory was deleted", name)) #nolint
  })
  # if argument reset is true, reset the project to the current one
  if (reset) {
    resetProj(current)
  }

  invisible(TRUE)

  # if argument open is true, open the project in RStudio
  if (open){
    rstudioapi::openProject(file.path(folder, name), newSession = TRUE)
  }
}