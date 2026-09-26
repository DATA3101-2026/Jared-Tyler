Assignment 2a
================
Jared Tyler
2026-09-25

## filter()

**Question**: How many flights had a departure delay longer than 3
hours?

``` r
# use filter without pipe
filter(flights, dep_delay > 180)
```

    ## # A tibble: 3,893 × 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
    ##  1  2013     1     1      848           1835       853     1001           1950
    ##  2  2013     1     1     1815           1325       290     2120           1542
    ##  3  2013     1     1     1842           1422       260     1958           1535
    ##  4  2013     1     1     2006           1630       216     2230           1848
    ##  5  2013     1     1     2115           1700       255     2330           1920
    ##  6  2013     1     1     2205           1720       285       46           2040
    ##  7  2013     1     1     2312           2000       192       21           2110
    ##  8  2013     1     1     2343           1724       379      314           1938
    ##  9  2013     1     2     1244            900       224     1431           1104
    ## 10  2013     1     2     1332            904       268     1616           1128
    ## # ℹ 3,883 more rows
    ## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
    ## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
    ## #   hour <dbl>, minute <dbl>, time_hour <dttm>

``` r
# use filter with pipe
# create a new data frame called flights_delay_180
flights_delay_180 <- flights |> filter(dep_delay > 180)

num_flights <- flights_delay_180 |> 
    summarise(count = n()) |> 
    pull(count)
```

> 3893 flights were delayed longer than 3 hours.

**Question**: Which flights departed on September 17, 2013?

``` r
flights |> filter(year == 2013, month == 9, day == 17)
```

    ## # A tibble: 961 × 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
    ##  1  2013     9    17      450            500       -10      624            648
    ##  2  2013     9    17      532            530         2      758            810
    ##  3  2013     9    17      537            545        -8      914            933
    ##  4  2013     9    17      539            545        -6      754            830
    ##  5  2013     9    17      543            545        -2      829            855
    ##  6  2013     9    17      544            550        -6      929            932
    ##  7  2013     9    17      549            600       -11      650            722
    ##  8  2013     9    17      550            600       -10      648            716
    ##  9  2013     9    17      551            600        -9      847            905
    ## 10  2013     9    17      551            600        -9      701            701
    ## # ℹ 951 more rows
    ## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
    ## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
    ## #   hour <dbl>, minute <dbl>, time_hour <dttm>

**Check-in**: What columns do we need to use to set our conditions?

> `year`, `month`, and `day`

## arrange()

**Task**: Arrange the flights by departure time.

``` r
flights |> arrange(year, month, day, dep_time)
```

    ## # A tibble: 336,776 × 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
    ##  1  2013     1     1      517            515         2      830            819
    ##  2  2013     1     1      533            529         4      850            830
    ##  3  2013     1     1      542            540         2      923            850
    ##  4  2013     1     1      544            545        -1     1004           1022
    ##  5  2013     1     1      554            600        -6      812            837
    ##  6  2013     1     1      554            558        -4      740            728
    ##  7  2013     1     1      555            600        -5      913            854
    ##  8  2013     1     1      557            600        -3      709            723
    ##  9  2013     1     1      557            600        -3      838            846
    ## 10  2013     1     1      558            600        -2      753            745
    ## # ℹ 336,766 more rows
    ## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
    ## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
    ## #   hour <dbl>, minute <dbl>, time_hour <dttm>

**Check-in**: Which column(s) do we need to use to arrange the data
frame?

> `year`, `month`, `day`, and `dep_time`
>
> That is, assuming that we want the data frame “arranged by departure
> time” in a *meaningful* way. If we actually just want it arranged by
> the time of departure, regardless of which day it was on, we would
> simply use `flights |> arrange(dep_time)`. But that would rarely (if
> ever) be useful, so I presume the former option is the one we want.

**Task**: Arrange the data frame to find the longest departure delay.

``` r
flights |> arrange(desc(dep_delay))
```

    ## # A tibble: 336,776 × 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
    ##  1  2013     1     9      641            900      1301     1242           1530
    ##  2  2013     6    15     1432           1935      1137     1607           2120
    ##  3  2013     1    10     1121           1635      1126     1239           1810
    ##  4  2013     9    20     1139           1845      1014     1457           2210
    ##  5  2013     7    22      845           1600      1005     1044           1815
    ##  6  2013     4    10     1100           1900       960     1342           2211
    ##  7  2013     3    17     2321            810       911      135           1020
    ##  8  2013     6    27      959           1900       899     1236           2226
    ##  9  2013     7    22     2257            759       898      121           1026
    ## 10  2013    12     5      756           1700       896     1058           2020
    ## # ℹ 336,766 more rows
    ## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
    ## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
    ## #   hour <dbl>, minute <dbl>, time_hour <dttm>

``` r
longest_dep_delay <- flights |>
    arrange(desc(dep_delay)) |>
    first() |> 
    pull(dep_delay)
```

> The longest departure delay was 1301 minutes.

## distinct()
