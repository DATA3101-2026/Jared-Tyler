#' ---
#' title: 'Assignment 2'
#' author: 'Jared Tyler'
#' output: github_document
#' ---

#+ echo=FALSE, message=FALSE
library(tidyverse)
library(dplyr)
library(nycflights13)

flights
glimpse(flights)
?flights

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

#'
#'
#' ## 3.2.5 Exercises

#'
#' 1. **In a single pipeline for each condition, find all flights that meet the condition:**

#'
#' - Had an arrival delay of two or more hours

flights |> filter(arr_delay >= 120)

#'
#' - Flew to Houston (`IAH` or `HOU`)

flights |> filter(dest %in% c('IAH', 'HOU'))

#'
#' - Were operated by United, American, or Delta

# these are the airline abbreviations as found in the `airlines` data frame
flights |> filter(carrier %in% c('UA', 'AA', 'DL'))

#'
#' - Departed in summer (July, August, and September)

flights |> filter(month >= 7, month <= 9)

#'
#' - Arrived more than two hours late but didn't leave late

# arriving more than 120 minutes (2 hours) late
# flights only left late if their dep_delay is positive
flights |> filter(arr_delay > 120, dep_delay <= 0)

#'
#' - Were delayed by at least an hour, but made up over 30 minutes in flight

# delayed by AT LEAST an hour means it could have left 60 minutes late OR LATER
# if it made up 30 minutes in flight, its delay on arrival must be 30 minutes LESS THAN its delay on departure
flights |> filter(dep_delay >= 60, arr_delay < (dep_delay - 30))

#'
#' 4. **Was there a flight on every day of 2013?**

flights |> distinct(year, month, day) |> count()

#'
#' > Yes. Using `distinct(year, month, day)` should produce one row per day that there was a flight, and it produced 365 rows. Since 2013 was _not_ a leap year, it only had 365 days. Therefore, there was a flight on every single day.

#'
#' 5a. **Which flights traveled the farthest distance?**

# arranging by `desc(distance)` will show us flights with the LARGEST `distance` at the top
flights |> arrange(desc(distance))

#'
#' 5b. **Which traveled the least distance?**

# arranging by `distance` on its own will show us flights with the SMALLEST `distance` at the top
flights |> arrange(distance)
