% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/usePuddingTheme.R
\name{puddingTheme}
\alias{puddingTheme}
\title{Use Pudding Theme}
\usage{
puddingTheme(toc = TRUE, code_folding = "show",
  number_sections = FALSE)
}
\arguments{
\item{toc}{Whether to include a sticky table of contents automatically, Default: TRUE}

\item{code_folding}{Should code be showing or hidden by default (options: "show", "hide"), Default: 'show'}

\item{number_sections}{Should each chapter be numbered by default?, Default: FALSE}
}
\value{
OUTPUT_DESCRIPTION
}
\description{
This is used within the YAML of a new Rmd document to use the Pudding Styled Theme
}
\details{
DETAILS
}
\examples{
\dontrun{
# in the YAML of your .Rmd file:
title: "Pudding Styled Report"
author: "Your Name"
date: "today"
output:
  puddingR::puddingTheme:
    toc: true
    code_folding: "show"
    number_sections: "false"
}
}
\seealso{
\code{\link[rmarkdown]{html_document}}
}
