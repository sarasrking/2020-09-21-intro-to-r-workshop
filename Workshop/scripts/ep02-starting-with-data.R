#   _____ _             _   _                        _ _   _       _____        _        
#  / ____| |           | | (_)                      (_| | | |     |  __ \      | |       
# | (___ | |_ __ _ _ __| |_ _ _ __   __ _  __      ___| |_| |__   | |  | | __ _| |_ __ _ 
#  \___ \| __/ _` | '__| __| | '_ \ / _` | \ \ /\ / | | __| '_ \  | |  | |/ _` | __/ _` |
#  ____) | || (_| | |  | |_| | | | | (_| |  \ V  V /| | |_| | | | | |__| | (_| | || (_| |
# |_____/ \__\__,_|_|   \__|_|_| |_|\__, |   \_/\_/ |_|\__|_| |_| |_____/ \__,_|\__\__,_|
#                                    __/ |                                               
#                                   |___/                                                
#
# Based on: https://datacarpentry.org/R-ecology-lesson/02-starting-with-data.html



# Lets download some data (make sure the data folder exists)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

# now we will read this "csv" into an R object called "surveys"
surveys <- read.csv("data_raw/portal_data_joined.csv")

# and take a look at it

surveys
head(surveys)
view(surveys)
class(surveys)
str(surveys)
dim(surveys)
nrow(surveys)
ncol(surveys)
# BTW, we assumed our data was comma separated, however this might not
# always be the case. So we may been to tell read.csv more about our file.



# So what kind of an R object is "surveys" ?

dataframe

# ok - so what are dataframes ?

tables

# --------
# Exercise
# --------
#
# What is the class of the object surveys?
#
# Answer: dataframe


# How many rows and how many columns are in this survey ?
#
# Answer: 34786 row x 13 col

# What's the average weight of survey animals

head(surveys, 20)
tail(surveys, 2)
names(surveys)
rownames(surveys)
summary(surveys)

Mean   : 42.67 

# Answer:

# Are there more Birds than Rodents ?
#
#

No - 

taxa      
Bird   :  450  
Rabbit :   75  
Reptile:   14  
Rodent :34247  

# Answer:


# 
# Topic: Sub-setting
#

# first element in the first column of the data frame (as a vector)

surveys[1,1]
# first element in the 6th column (as a vector)
surveys[1,6]

# first column of the data frame (as a vector)

surveys[,6]
# first column of the data frame (as a data frame)

surveys[1]
head(surveys[1])
head(surveys[,1])
# first row (as a data frame)
surveys[1, ]

# first three elements in the 7th column (as a vector)

surveys[1:3, 7]

the third element is blank in the table
# the 3rd row of the data frame (as a data.frame)

surveys[3,]

# equivalent to head(metadata)

head(surveys)
surveys[1:6, 1]
# looking at the 1:6 more closely

1:6
5:10

surveys[c(1,2,3,4,5,6)]

# we also use other objects to specify the range

rows <- 6
surveys[1:6, 3]
surveys[1:rows, 3]

#
# Challenge: Using slicing, see if you can produce the same result as:
#
#   tail(surveys)
#
# i.e., print just last 6 rows of the surveys dataframe
#
# Solution:

surveys[34781:34786, ]

surveys[tail-6]

nrow(surveys)
surveys[34781:nrow(surveys),]
surveys[(nrow(surveys)-5):nrow(surveys), 1]
length(surveys)
length(surveys[,1])

# We can omit (leave out) columns using '-'

surveys[-1]
surveys[c(-1, -2, -3)]
head(surveys[c(-1, -2, -3)])
head( surveys[-(1:3)])
# column "names" can be used in place of the column numbers

head(surveys["month"])
head(surveys[c("month", "year")])

#
# Topic: Factors (for categorical data)
#
gender <- factor( c("male", "female"))
gender

# factors have an order

temperature <- factor( c("hot", "cold", "warm"))
temperature[1]
temperature[2]
temperature[3]
temperature
levels(temperature)
temperature <- factor( c("hot", "cold", "warm"), level = c("cold", "warm", "hot") )
levels(temperature)

# Converting factors
as.numeric(temperature)
as.character(temperature)
# can be tricky if the levels are numbers
year <- factor( c(1990, 1977, 1998, 1990))
year
as.numeric(year)
as.character(year)
as.numeric( as.character(year))
# so does our survey data have any factors
str(surveys)

#
# Topic:  Dealing with Dates
#
library(lubridate)
my_date <- ymd("2015-01-01")
class(my_date)

# R has a whole library for dealing with dates ...
paste("abc", "123", "xyz", sep = "-")

paste("2015", "01", "26", sep = "-")

ymd(paste("2015", "01", "26", sep = "-"))
my_date <- ymd(paste("2015", "01", "26", sep = "-"))
class(my_date)

# R can concatenated things together using paste()


# 'sep' indicates the character to use to separate each component


# paste() also works for entire columns

ymd( paste(surveys$year, surveys$month, surveys$day, sep = "-"))

# let's save the dates in a new column of our dataframe surveys$date 

surveys$date <- ymd( paste(surveys$year, surveys$month, surveys$day, sep = "-"))

# and ask summary() to summarise 

str(surveys)

summary(surveys)
# but what about the "Warning: 129 failed to parse"

#some data cannot be converted to dates
 summary(surveys$date)
 missing_date <- is.na(surveys$date)
 missing_date <- surveys[is.na(surveys$date), "date"]
 missing_date
 missing_date <- surveys[is.na(surveys$date), c("year", "month", "day")]
summary(missing_date) 

# can't be converted because some months don't have 31 days

missing_date <- surveys[is.na(surveys$date), c("record_id", "year", "month", "day")]
missing_date
