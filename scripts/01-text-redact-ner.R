##################################
#
# Use NER for text redaction
#
# Author: Meltem Odabas
# Date: 2025-07-17
#
##################################

# make sure to download transformers and torch to python before you start


# load packages----
library(reticulate)
library(stringr)

# load data ----
mission_text <- str_c(readLines("data/haverford_mission_statement.txt", warn = FALSE), collapse = " ")


# import transformers pipeline ----
transformers <- import("transformers")

# initialize ner pipeline ----
# using default model: 'dbmdz/bert-large-cased-finetuned-conll03-english'
ner <- transformers$pipeline("ner", aggregation_strategy="simple")


# function to redact text ----
redact_text <- function(text) {
  entities <- ner(text)
  
  # entities is a list of named entity dicts with 'start', 'end', 'entity_group' and 'word'
  
  # Sort entities by start descending to replace safely
  entities <- entities[order(sapply(entities, function(x) -x$start))]
  
  redacted_text <- text
  
  for (entity in entities) {
    start <- entity$start + 1  # R is 1-based index
    end <- entity$end
    label <- entity$entity_group
    
    # Replace entity span with [LABEL]
    redacted_text <- paste0(
      substr(redacted_text, 1, start - 1),
      "[", label, "]",
      substr(redacted_text, end + 1, nchar(redacted_text))
    )
  }
  
  return(redacted_text)
}

redacted_text <- redact_text(mission_text)

