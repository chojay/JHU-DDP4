# Read Me

## Introduction
This Shiny app uses the total world population dataset from [worldbank.org](http://data.worldbank.org/indicator/SP.POP.TOTL). 

Dataset used here is a 'cleaned' version of the raw dataset file available [here](http://api.worldbank.org/v2/en/indicator/SP.POP.TOTL?downloadformat=csv). The pre-processing/cleaning step is included in R markdown file in github. The geographic coordinate system data (latitude and longitude) was then joined to the pre-processed data by running [geocode](https://www.rdocumentation.org/packages/ggmap/versions/2.6.1/topics/geocode) function of [ggmap package](https://www.rdocumentation.org/packages/ggmap/versions/2.6.1) to each row by the [map function](https://www.rdocumentation.org/packages/purrr/versions/0.2.2/topics/map) from [purrr package](https://www.rdocumentation.org/packages/purrr/versions/0.2.2).

'Read Me' section was written in [Markdown](https://en.wikipedia.org/wiki/Markdown) and displayed in Shiny through [markdown package](https://www.rdocumentation.org/packages/markdown/versions/0.7.7).

## Instruction

The way the app is designed straightforward:

* Choose the year of interest by the drop-down menu
* Choose the ranges of population of interest by the slider inputs
* The list of countries subsetted based on the two items above will get displayed on the table shown at the bottom


## Libraries

Libraries used in this app are as follows:

* [library(tidyverse)](http://tidyverse.org/)
* [library(ggmap)](https://www.rdocumentation.org/packages/ggmap/versions/2.6.1)
* [library(purrr)](https://github.com/hadley/purrr)
* [library(leaflet)](https://rstudio.github.io/leaflet/)
* [library(markdown)](https://www.rdocumentation.org/packages/markdown/versions/0.7.7))