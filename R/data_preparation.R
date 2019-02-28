library(tidyverse)

# https://www.gapminder.org/data/

# read csv for PIB and LifeExp
gdpPercap <- read_csv('./data/income_per_person_gdppercapita_ppp_inflation_adjusted.csv')
lifeExp <- read_csv('./data/life_expectancy_years.csv')

# Filter for LatAm countries
hispam_vec <- c(
  'Argentina', 'Brazil', 'Bolivia', 'Chile', 'Colombia',
  'Costa Rica', 'Cuba', 'Dominican Republic',
  'Ecuador', 'El Salvador', 'Guatemala', 'Honduras',
  'Mexico', 'Nicaragua', 'Panama', 'Paraguay',
  'Peru', 'Uruguay',
  'Spain', 'Puerto Rico',
  'Venezuela' )

# dplyr::filter countries in hispam
######
gdpPercap <- filter(gdpPercap, country %in% hispam_vec)
lifeExp <- filter(lifeExp, country %in% hispam_vec)

# tidyr::gather year columns for PIB and LifeExp
gdpPercap_tidy <- gather(gdpPercap, "year", "gdpPercap", -1)
lifeExp_tidy <- gather(lifeExp, "year", "lifeExp", -1)

######


# dplyr::inner_join tidyr version of PIB and LifeExp
gapminder_hispam <- inner_join(gdpPercap_tidy, lifeExp_tidy,
           by = c("country" = "country", "year" = "year"))

# function to assing country code
assign_code <- function(country_name){
  country_code = 'ar'
  return(country_code)
}

countries <- list(Argentina = 'ar',
                  Brazil = 'br',
                  Bolivia = 'bo',
                  Chile = 'cl',
                  Colombia = 'co',
                  Costa_Rica = 'cr',
                  Cuba = 'cu',
                  Dominican_Republic = 'do',
                  Ecuador = 'ec',
                  El_Salvador = 'sv',
                  Guatemala = 'gt',
                  Honduras = 'hn',
                  Mexico = 'mx',
                  Nicaragua = 'ni',
                  Panama = 'pa',
                  Paraguay = 'py',
                  Peru = 'pe',
                  Puerto_Rico = 'pr',
                  Spain = 'es',
                  Uruguay = 'uy',
                  Venezuela = 've')

assign_code <- function(country_name){
  # white spaced country name
  if (country_name == 'Costa Rica') {
    country_name <- 'Costa_Rica'
  } else if (country_name == 'Dominican Republic') {
    country_name <- 'Dominican_Republic'
  } else if (country_name == 'El Salvador') {
    country_name <- 'El_Salvador'
  } else if (country_name == 'Puerto Rico') {
    country_name <- 'Puerto_Rico'
  }
  # para todos los demas
  country_code <- countries[[country_name]]
  return(country_code)
}


gapminder_hispam <- mutate(gapminder_hispam,
                           code = mapply(assign_code, as.character(country)),
                           log_gdppc = log10(gdpPercap/4))
