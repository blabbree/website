# This script builds both the HTML and PDF versions of your CV

# If you wanted to speed up rendering for googlesheets driven CVs you could use
# this script to cache a version of the CV_Printer class with data already
# loaded and load the cached version in the .Rmd instead of re-fetching it twice
# for the HTML and PDF rendering. This exercise is left to the reader.

current_date <- Sys.time()
current_date <- format(current_date,format='%Y%m%d%_T%I%M%S')

basename <- paste0("Labbree_CV_",current_date)

# Knit the HTML version

rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = FALSE),
                  output_file = paste0("HTML/",basename,".html"))

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = TRUE),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = paste0("PDF/",basename,".pdf"))
