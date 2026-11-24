library(tidyverse) # Add comments about any of the new packages you may not recognize
library(rvest)
library(httr2)
library(jsonlite)
library(purrr)
library(dplyr)

# ---- Nova Scotia tutorial ----

# test rvest with wikipedia article about the area surrounding the dataset we are looking at today

link <- "https://en.wikipedia.org/wiki/List_of_counties_of_Nova_Scotia"
page <- read_html(link)

# This is a long variable name. What would you shorten it to?
novaScotiaCounties <- data.frame(page |> 
								 	html_element("table.wikitable.sortable") |> 
								 	html_table())

# I'll use this name for my code
nsc <- data.frame(page |> 
				  	html_element("table.wikitable.sortable") |> 
				  	html_table())

# Test out the command in your console below. What do the numbers mean?
# > dim(final)

# Let's look at the names of the dataframe

colnames(nsc) # What are the numbers in these columns from? Check out the wiki page if you don't know!

# What if we want to see which population number is biggest?

# Let's clean up the 2021 population name
names(nsc)[names(nsc) == 'Population.2021..7.'] <- 'Population_2021'

# What happens when we run this?
#nsc$Population_2021 <- as.numeric(as.character(nsc$Population_2021))

# Let's try again.
# Comment out the previous command and run up to this line.
nsc$Population_2021 <- gsub(",","", nsc$Population_2021) #What does this line do?
nsc$Population_2021 <- as.numeric(as.character(nsc$Population_2021)) # How does it work now?

max(nsc$Population_2021) # What county is this?

# Answer:
print("Trick question! This is for the total of all the counties in NS. Use max(nsc$Population_2021[1:18]) and try again.")


# ---- Let's do this with New Brunswick counties ----

nblink <- "https://en.wikipedia.org/wiki/List_of_counties_of_New_Brunswick"
nbpage <- read_html(nblink)

nbc <- data.frame(nbpage |>
				  	html_element("table.wikitable.sortable") |> 
				  	html_table())

colnames(nbc) # What are the numbers in these columns from? Check out the wiki page if you don't know


# Preparation for assignment 7, assignment 8
