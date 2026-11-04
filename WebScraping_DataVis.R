library(tidyverse)
library(rvest)
library(httr2)
library(jsonlite)
library(purrr)
library(dplyr)

#---- Assignment 6 prep: Data visualization Walk-through & Intro ----

#---- Using Tidy Tuesday's provided data loading and cleaning code. ----
library(tidytuesdayR) # What is Tidy Tuesday?

tuesdata <- tidytuesdayR::tt_load('2026-03-31')

#---- Set up the datasets ----
ocean_temperature <- tuesdata$ocean_temperature
ocean_temperature_deployments <- tuesdata$ocean_temperature_deployments

# Create a new dataset that merges the two
ocean_temp <- cross_join(ocean_temperature, ocean_temperature_deployments, copy = FALSE) |> # how does cross_join compare to left_join or full_join?
	filter(date >= start_date, date <= end_date) # What is this filter doing?

#---- Let's look at the data! ----
library(ggplot2)

ggplot(ocean_temp) +
	geom_area(mapping=aes(mean_temperature_degree_c, date, colour = deployment_id)) # what happens if we do geom_line() instead?

#---- ... ----
ggplot(ocean_temp) +
	geom_area(mapping=aes(date, mean_temperature_degree_c, colour = deployment_id)) # Did you catch why the last graph looked funny? Which axis goes first, second?

# is there anything distracting or unclear about this plot?

#---- Let's make the colours a bit more smooth. ----
ggplot(ocean_temp) + geom_area(mapping=aes(date, mean_temperature_degree_c, colour = deployment_id, fill = deployment_id))

# Check your file to see if the area looks better, then save the plot using the "export" function into your repo folder. Commit, and push the image alongside the updated code with a clear comment.
