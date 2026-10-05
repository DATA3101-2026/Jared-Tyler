#' ---
#' title: 'Assignment 2a'
#' author: 'Jared Tyler'
#' output: github_document
#' ---

#+ echo=FALSE, message=FALSE
library(tidyverse)
library(dplyr)
library(nycflights13)

flights
glimpse(flights)

#' 
#' 
#' ## filter()

#'
#' **Various tutorial snippets**:
flights |> filter(dep_delay > 120)
flights |> filter(month == 1 & day == 1)
flights |> filter(month == 1, day == 1)
flights |> filter(month %in% c(1, 2))
jan1 <- flights |> filter(month == 1, day == 1)
flights |> filter(month == 1, day == 1) -> jan1

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
#' 
#' ## arrange()

#'
#' **Various tutorial snippets**:
flights |> arrange(year, month, day, dep_time)
flights |> arrange(desc(dep_delay))

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
#' 
#' ## distinct()

#'
#' **Various tutorial snippets**:
flights |> distinct()
flights |> distinct(origin)
flights |> distinct(origin, dest)
flights |> distinct(origin, dest, .keep_all = TRUE)
flights |> count(origin, dest, sort = TRUE)

#'
#' **Question**: Are there any duplicate rows>
num_flights <- flights |> count()
num_distinct <- flights |> distinct() |> count()
#'
#' > No, there aren't any duplicate rows, since there are `r num_flights` rows in the dataset and there are still `r num_distinct` unique rows.

#'
#' **Question**: How many unique origin and destination pairs are there in this data frame?
num_pairs <- flights |> distinct(origin, dest) |> count()
flights |> distinct(origin, dest)
#'
#' > There are `r num_pairs` unique pairs.
