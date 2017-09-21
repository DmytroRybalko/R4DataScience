library(tidyverse)
library(stringr)

x <- c("apple", "banana", "pear")
# Find word with four letter long
str_view(x, "^....$")
# Find word has five letters or more
str_view(x, "^.....")

# Start with a vowel
str_view(x, "^[aeio]")

# Start with consonants
str_view(x, "^[^aeio]")

# End with ed, but not with eed
str_view(c("aed", "dfgedef", "adfeed"), "(ed)$")

# End with ing or ise
str_view(c("aeding", "dfgedefisee", "adfise"), "(ing|ise)$")

# Start with three consonants
str_view(c("aeding", "dfgedefisee", "adfise"), "^[^aeio]{3}")

# Have three or more vowels in a row
str_view(c("aeding", "dfgedefisee", "adfse"), "[aeio]{.}")

# Have two or more vowel-consonant pairs in a row.
str_view(c("eadiang", "dfgedf", "adfsii"), ".(aeio){2,}.")

str_view(c("eaddidaang", "dfgedf", "adfsii"), "(.)\\1")
str_view(c("eaddiddaang", "dfggedf", "adffsii"), "(..)\\1")

# Extract matches ex.
head(sentences)
# We want to find all sentences that contain a colour
colour <- c("\\bred\\b", "\\byellow\\b", "\\bblue\\b", "\\bgreen\\b",
            "\\borange\\b", "\\bpurple\\b")
# Make  single regular expression:
colour_match <- str_c(colour, collapse = "|")
# Now we can select the sentences that contain a colour
has_colour <- str_subset(sentences, colour_match)
# Select colours from the sentences
matches <- str_extract(has_colour, colour_match)
# Select sentences that contains more then one colour
more <- sentences[str_count(sentences, colour_match) > 1]
more
str_view_all(more, colour_match)

# Extract the first word from each sentence
str_view(more, "[A-Z][a-z]+\\b")
first_word <- "[A-Z][a-z]+\\b"
str_extract(more, first_word)
first_words <- str_extract(sentences, first_word)

# Find all words ending "ing"
ing <- "ell\\b"
ing_words <- str_extract(sentences, ing)
