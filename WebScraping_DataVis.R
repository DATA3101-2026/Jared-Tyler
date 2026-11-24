library(tidyverse) # Add comments about any of the new packages you may not recognize
library(rvest)
library(httr2)
library(jsonlite)
library(purrr)
library(dplyr)
library(RJSONIO)
library(rinat)

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


# ---- Preparation for assignment 7, assignment 8 ----

lat <- 45.902055  # Dunn building coords
lon <- -64.373069

# Creating an API request
resp <- request("https://api.open-meteo.com/v1/forecast") |>
	req_url_query(
		latitude = lat,
		longitude = lon,
		current = "temperature_2m,wind_speed_10m,wind_direction_10m,cloud_cover"
	) |>
	req_perform()

weather <- resp_body_json(resp)
weather$current

# Saving weather dataset as a json file
weatherJson <- toJSON(weather)
write(weatherJson, "weather-test.json")

# species in the area
inat <- request("https://api.inaturalist.org/v1/observations") |>
	req_url_query(lat = lat, lng = lon, radius = 1, per_page = 50,
				  quality_grade = "research") |>
	req_perform() |>
	resp_body_json()

species <- sapply(inat$results, \(x) x$taxon$name)
table(species)

# Save species information
specJson <- toJSON(species)
write(specJson, "species-test.json")

# ---- Using rinat ----

# Some groups will have either proprietary or open-source versions 
#  of their api for an easier time getting data

# Creating request for specific species
nymphalidae <- get_inat_obs(taxon_name  = "Nymphalidae", year = 2026, month = 8)
# how many unique taxa?
length(unique(nymphalidae$scientific_name))

# Get data from iNaturalist for Monarch Butterflies, searching by date (August 2026)
monarchs <- get_inat_obs(query = "Monarch Butterfly", year = 2026, month = 8)

# which taxa were returned? What does this mean?
unique(monarchs$scientific_name)

