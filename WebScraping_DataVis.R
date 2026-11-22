library(tidyverse)
library(rvest)
library(httr2)
library(jsonlite)
library(purrr)
library(dplyr)

#---- Assignment 6 prep: Data visualization Walk-through & Intro ----

# Using Tidy Tuesday's provided data loading and cleaning code.
library(tidytuesdayR)

tuesdata <- tidytuesdayR::tt_load('2026-03-31')

# Set up the datasets
ocean_temperature <- tuesdata$ocean_temperature
ocean_temperature_deployments <- tuesdata$ocean_temperature_deployments

# Create a new dataset that merges the two
ocean_temp <- cross_join(ocean_temperature, ocean_temperature_deployments, copy = FALSE) |>
	filter(date >= start_date, date <= end_date)

# Let's look at the data!
library(ggplot2)

ggplot(ocean_temp) +
	geom_area(mapping=aes(mean_temperature_degree_c, date, colour = deployment_id))

# Swap the axes.
ggplot(ocean_temp) +
	geom_area(mapping=aes(date, mean_temperature_degree_c, colour = deployment_id))

# Let's make the colours a bit more smooth.
ggplot(ocean_temp) + geom_area(mapping=aes(date, mean_temperature_degree_c, colour = deployment_id, fill = deployment_id))


#---- Assignment 6 ----

# Plot 1: Improve the class plot
ggplot(ocean_temp) +
	geom_area(mapping = aes(x = date, y = mean_temperature_degree_c, colour = deployment_id, fill = deployment_id)) +
	labs(
		title = "Ocean Temperature at Birchy Cove, NS",
		x = "Date of Measurement",
		y = "Mean Water Temperature (°C)",
		caption = "Data Source: tidytuesdayR::tt_load('2026-03-31')",
	)

# Plot 2: A single deployment
ggplot(ocean_temp |> filter(deployment_id == 'depl_11')) +
	geom_line(colour = 'cyan', mapping = aes(x = date, y = mean_temperature_degree_c)) +
	labs(
		title = "Ocean Temperature at Birchy Cove, NS",
		subtitle = "Deployment 11 (Nov. 10, 2023 – May 2, 2024)",
		x = "Date of Measurement",
		y = "Mean Water Temperature (°C)",
		caption = "Data Source: tidytuesdayR::tt_load('2026-03-31')",
	)

# Plot 3: A different deployment, with standard deviation
ggplot(ocean_temp |> filter(deployment_id == 'depl_03')) +
	geom_line(mapping = aes(colour = 'Mean + SD', x = date, y = mean_temperature_degree_c + sd_temperature_degree_c)) +
	geom_line(mapping = aes(colour = 'Mean – SD', x = date, y = mean_temperature_degree_c - sd_temperature_degree_c)) +
	geom_line(mapping = aes(colour = 'Mean', x = date, y = mean_temperature_degree_c)) +
	scale_colour_manual(name = 'Legend', values = c(
		'Mean' = 'red',
		'Mean + SD' = 'darkblue',
		'Mean – SD' = 'darkblue'
	)) +
	labs(
		title = "Ocean Temperature at Birchy Cove, NS",
		subtitle = "Deployment 3 (May 2, 2019 – Nov. 22, 2019), incl. standard deviation",
		x = "Date of Measurement",
		y = "Water Temperature (°C)",
		caption = "Data Source: tidytuesdayR::tt_load('2026-03-31')",
	)
