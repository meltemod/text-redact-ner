# Named Entity Recognition (NER) for Text Redaction

This project uses a pre-trained transformer model to identify and redact named entities from text using Python's `transformers` library within an R environment via `reticulate`.

## Overview

The script loads a mission statement text file and applies a Named Entity Recognition (NER) pipeline to detect named entities like `PERSON`, `ORG`, `LOCATION`, and more. These entities are then redacted from the text and replaced with their entity labels (e.g., `[PERSON]`, `[ORG]`).

## Dependencies

Before running the script, make sure the following Python packages are installed in your environment:

```bash
pip install transformers torch
```

In R, you'll also need the following packages:

```r
install.packages(c("reticulate", "stringr"))
```

## Example Output
Original Text:

```
Haverford College, located near Philadelphia, was founded by Quakers.

```

Redacted Output:
```
[ORG], located near [LOC], was founded by [ORG].
```

