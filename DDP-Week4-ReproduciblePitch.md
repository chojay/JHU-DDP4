DDP-Week4-ReproduciblePitch
========================================================
author: Jay Cho
date: 03/11/2017
autosize: true

World Population Exploration
========================================================

This project explores the world population in 1960 - 2015 based on population data from World Bank Data, made into a Shiny app to display population density infographically

The steps involved are as following:
- Download data & pre-process (Available in detail in R Markdown file at Github)
- Add geographic coordinate system to be able to display location info in Leaflet (Available in detail in R Markdown file)
- Map the completed info to Leaflet & Shiny

In the slides to follow, we will go over how each step was approached, followed by a simple data exploration as to which country had the most population in each year.

Data Load 
========================================================
- Will import cleaned data and do some basic analysis

```r
library(tidyverse)

popdata <- read.csv("popdata_cleaned.csv")

popdata %>%
  select(-c(lon,lat)) %>% #Removing lon and lat
  str()
```

```
'data.frame':	216 obs. of  58 variables:
 $ Country.Name: Factor w/ 216 levels "Afghanistan",..: 10 5 1 6 2 205 8 9 4 7 ...
 $ Country.Code: Factor w/ 216 levels "ABW","AFG","AGO",..: 1 5 2 3 4 6 7 8 9 10 ...
 $ Year_1960   : int  54208 13414 8994793 5270844 1608800 92612 20619075 1867396 20012 54681 ...
 $ Year_1961   : int  55435 14376 9164945 5367287 1659800 100985 20953079 1934239 20478 55403 ...
 $ Year_1962   : int  56226 15376 9343772 5465905 1711319 112240 21287682 2002170 21118 56311 ...
 $ Year_1963   : int  56697 16410 9531555 5565808 1762621 125216 21621845 2070427 21883 57368 ...
 $ Year_1964   : num  57029 17470 9728645 5665701 1814135 ...
 $ Year_1965   : int  57360 18551 9935358 5765025 1864791 150318 22283389 2204650 23518 59653 ...
 $ Year_1966   : int  57712 19646 10148841 5863568 1914573 161077 22608747 2269475 24320 60818 ...
 $ Year_1967   : int  58049 20755 10368600 5962831 1965598 171781 22932201 2332624 25116 62002 ...
 $ Year_1968   : int  58385 21888 10599790 6066094 2022272 185312 23261273 2394635 25886 63176 ...
 $ Year_1969   : int  58724 23061 10849510 6177703 2081695 205570 23605992 2456370 26615 64307 ...
 $ Year_1970   : int  59065 24279 11121097 6300969 2135479 235434 23973062 2518408 27292 65369 ...
 $ Year_1971   : int  59438 25560 11412821 6437645 2187853 275160 24366442 2580894 27916 66338 ...
 $ Year_1972   : int  59849 26892 11716896 6587647 2243126 324069 24782950 2643464 28490 67205 ...
 $ Year_1973   : int  60239 28231 12022514 6750215 2296752 382823 25213388 2705584 29014 67972 ...
 $ Year_1974   : int  60525 29514 12315553 6923749 2350124 451948 25644505 2766495 29491 68655 ...
 $ Year_1975   : int  60655 30706 12582954 7107334 2404831 531265 26066975 2825650 29932 69253 ...
 $ Year_1976   : int  60589 31781 12831361 7299508 2458526 622051 26477153 2882831 30325 69782 ...
 $ Year_1977   : int  60366 32769 13056499 7501320 2513546 722849 26878567 2938181 30690 70223 ...
 $ Year_1978   : int  60106 33746 13222547 7717139 2566266 827394 27277742 2991954 31105 70508 ...
 $ Year_1979   : int  59978 34819 13283279 7952882 2617832 927303 27684530 3044564 31670 70553 ...
 $ Year_1980   : int  60096 36063 13211412 8211950 2671997 1016789 28105889 3096298 32456 70301 ...
 $ Year_1981   : int  60567 37502 12996923 8497950 2726056 1093108 28543366 3145885 33488 69750 ...
 $ Year_1982   : int  61344 39112 12667001 8807511 2784278 1158477 28993989 3192877 34740 68950 ...
 $ Year_1983   : int  62204 40862 12279095 9128655 2843960 1218223 29454739 3239212 36165 67958 ...
 $ Year_1984   : int  62831 42704 11912510 9444918 2904429 1280278 29920907 3287588 37687 66863 ...
 $ Year_1985   : int  63028 44597 11630498 9745209 2964762 1350433 30388781 3339147 39247 65744 ...
 $ Year_1986   : int  62644 46515 11438949 10023700 3022635 1430548 30857242 3396511 40835 64605 ...
 $ Year_1987   : int  61835 48458 11337932 10285712 3083605 1518991 31326473 3457054 42448 63484 ...
 $ Year_1988   : int  61077 50431 11375768 10544904 3142336 1613904 31795515 3510439 44049 62538 ...
 $ Year_1989   : int  61032 52449 11608351 10820992 3227943 1712117 32263559 3542720 45591 61967 ...
 $ Year_1990   : int  62148 54511 12067570 11127870 3286542 1811458 32729740 3544695 47044 61906 ...
 $ Year_1991   : int  64623 56674 12789374 11472173 3266790 1913190 33193920 3511912 48379 62412 ...
 $ Year_1992   : int  68235 58904 13745630 11848971 3247039 2019014 33655149 3449497 49597 63434 ...
 $ Year_1993   : int  72498 61003 14824371 12246786 3227287 2127863 34110912 3369673 50725 64868 ...
 $ Year_1994   : int  76700 62707 15869967 12648483 3207536 2238281 34558114 3289943 51807 66550 ...
 $ Year_1995   : int  80326 63854 16772522 13042666 3187784 2350192 34994818 3223173 52874 68349 ...
 $ Year_1996   : int  83195 64291 17481800 13424813 3168033 2467726 35419683 3173425 53926 70245 ...
 $ Year_1997   : int  85447 64147 18034130 13801868 3148281 2595220 35833965 3137652 54942 72232 ...
 $ Year_1998   : int  87276 63888 18511480 14187710 3128530 2733770 36241578 3112958 55899 74206 ...
 $ Year_1999   : int  89004 64161 19038420 14601983 3108778 2884188 36648054 3093820 56768 76041 ...
 $ Year_2000   : num  90858 65399 19701940 15058638 3089027 ...
 $ Year_2001   : int  92894 67770 20531160 15562791 3060173 3217865 37471535 3060036 58176 78972 ...
 $ Year_2002   : int  94995 71046 21487079 16109696 3051010 3394060 37889443 3047249 58729 80030 ...
 $ Year_2003   : int  97015 74783 22507368 16691395 3039616 3625798 38309475 3036420 59117 80904 ...
 $ Year_2004   : int  98742 78337 23499850 17295500 3026939 3975945 38728778 3025982 59262 81718 ...
 $ Year_2005   : int  100031 81223 24399948 17912942 3011487 4481976 39145491 3014917 59117 82565 ...
 $ Year_2006   : int  100830 83373 25183615 18541467 2992547 5171255 39558750 3002161 58648 83467 ...
 $ Year_2007   : int  101218 84878 25877544 19183907 2970017 6010100 39969903 2988117 57904 84397 ...
 $ Year_2008   : int  101342 85616 26528741 19842251 2947314 6900142 40381860 2975029 57031 85350 ...
 $ Year_2009   : int  101416 85474 27207291 20520103 2927519 7705423 40798641 2966108 56226 86300 ...
 $ Year_2010   : int  101597 84419 27962207 21219954 2913021 8329453 41222875 2963496 55636 87233 ...
 $ Year_2011   : int  101936 82326 28809167 21942296 2904780 8734722 41655616 2967984 55316 88152 ...
 $ Year_2012   : int  102393 79316 29726803 22685632 2900247 8952542 42095224 2978339 55227 89069 ...
 $ Year_2013   : int  102921 75902 30682500 23448202 2896652 9039978 42538304 2992192 55302 89985 ...
 $ Year_2014   : int  103441 72786 31627506 24227524 2893654 9086139 42980026 3006154 55434 90900 ...
 $ Year_2015   : int  103889 70473 32526562 25021974 2889167 9156963 43416755 3017712 55538 91818 ...
```

Adding Geocode for Leaflet
===================
- To add longitude and latitude, the [geocode](https://www.rdocumentation.org/packages/ggmap/versions/2.6.1/topics/geocode) function of [ggmap package](https://www.rdocumentation.org/packages/ggmap/versions/2.6.1) was mapped to each row by the [map function](https://www.rdocumentation.org/packages/purrr/versions/0.2.2/topics/map) from [purrr package](https://www.rdocumentation.org/packages/purrr/versions/0.2.2).

- In the example below, the code is shown if we were to run for the first 3 countries (as the process takes long if we were to run on the whole dataset.) The data being used in Shiny app had the geocode function run on all rows.

```r
df %>%
  slice(1:3) %>% #Keeping the first three rows
  select(Country.Name) %>% #Selecting country name to pass to map function
  as.character() %>% #changing to characters from factors
  map_df(geocode) -> #Mapping to geocode function
  geo_code_data
```



Let's check which country has the highest population per year
========================================================


```r
df <- popdata %>%
  select(-c(lon,lat)) 

popdata[unlist(apply(df, 2, which.max)),1] #Finding max population per column and print the corresponding country name
```

```
 [1] China China China China China China China China China China China
[12] China China China China China China China China China China China
[23] China China China China China China China China China China China
[34] China China China China China China China China China China China
[45] China China China China China China China China China China China
[56] China
216 Levels: Afghanistan Albania Algeria American Samoa Andorra ... Zimbabwe
```

- Looks like China had the highest population ever since 1960 (to 2015 hence 56 years total).
- More interactive information available at Shiny app
