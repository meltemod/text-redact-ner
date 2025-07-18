##################################
#
# Pull test to test NER for text redaction
#
# Author: Meltem Odabas
# Date: 2025-07-17
#
###################################

library(rvest)
library(stringr)

url <- "https://www.haverford.k12.pa.us/about/mission"

page <- read_html(url)

# Inspect the page HTML structure:
# The mission statement and goals are inside divs with class "rich-text" under main content

# Select the div with class "fsElementContent"
content_div <- page %>%
  html_node("div.fsPageBody")

# Extract all text
mission_text <- content_div %>%
  html_text2() %>%
  trimws()

# save mission statement
writeLines(mission_text, "data/haverford_mission_statement.txt")
