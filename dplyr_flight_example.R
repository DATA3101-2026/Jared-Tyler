#' ---
#' title: 'Assignment 2a'
#' author: 'Jared Tyler'
#' output: github_document
#' ---

#+ echo=FALSE, message=FALSE
library(tidyverse)
library(dplyr)
library(nycflights13)

#' 
#' ## filter()

#'
#' **Question**: How many flights had a departure delay longer than 3 hours?

# use filter without pipe
filter(flights, dep_delay > 180)

# use filter with pipe
# create a new data frame called flights_delay_180
flights_delay_180 <- flights |> filter(dep_delay > 180)

num_flights <- flights_delay_180 |> 
	summarise(count = n()) |> 
	pull(count)
#'
#' > `r num_flights` flights were delayed longer than 3 hours.

#'
#' **Question**: Which flights departed on September 17, 2013?
flights |> filter(year == 2013, month == 9, day == 17)

#'
#' **Check-in**: What columns do we need to use to set our conditions?
#' 
#' > `year`, `month`, and `day`

#' 
#' ## arrange()

#'
#' **Task**: Arrange the flights by departure time.
flights |> arrange(year, month, day, dep_time)

#'
#' **Check-in**: Which column(s) do we need to use to arrange the data frame?
#' 
#' > `year`, `month`, `day`, and `dep_time`  
#' > 
#' > That is, assuming that we want the data frame "arranged by departure time" in a _meaningful_ way.  If we actually just want it arranged by the time of departure, regardless of which day it was on, we would simply use `flights |> arrange(dep_time)`.  But that would rarely (if ever) be useful, so I presume the former option is the one we want.

#'
#' **Task**: Arrange the data frame to find the longest departure delay.
flights |> arrange(desc(dep_delay))

longest_dep_delay <- flights |>
	arrange(desc(dep_delay)) |>
	first() |> 
	pull(dep_delay)
#'
#' > The longest departure delay was `r longest_dep_delay` minutes.





#' 
#' ## distinct()

#+ echo=FALSE, message=FALSE

