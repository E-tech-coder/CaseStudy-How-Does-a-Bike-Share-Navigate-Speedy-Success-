# Connect R to mssql

install.packages("RODBC")
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("rmarkdown")

library(dplyr)
library(tidyr)
library(RODBC)
library(ggplot2)
library(scales)
library(rmarkdown)


dbcon <- odbcConnect("EC_SQL", rows_at_time = 1 )

if(dbcon == -1){
  quit("no", 1)
}

sql <- "
SELECT *
FROM CyclingData..[RidePerHour]
"
TotalTrip <- sqlQuery(dbcon, sql)

TotalTrip <- TotalTrip %>% arrange(START_HOUR)

View(TotalTrip)

plot01 <- ggplot(TotalTrip, aes(x = START_HOUR, y = AVG_DAY, group = member_casual, color = member_casual)) +
  geom_line() +
  labs(x = "Hour in a day", y = "Average Number of users", 
         title = "Average Number of riders of each type in each hour in a day", color = "rider type")

plot01 + annotate("text", x = 7, y = 400, label = "Another peak for members", size = 3)


sql02 <- "
SELECT *
FROM CyclingData..Summary
"

Ridelength_summary <- sqlQuery(dbcon, sql02)

View(Ridelength_summary %>% arrange(member_casual, rideable_type))

mean_plot <- ggplot(Ridelength_summary, aes(x= member_casual, y = mean , fill = rideable_type)) +
  geom_bar(position = "dodge",stat =  'identity') +
  geom_text(aes(label = mean),position=position_dodge(width=0.9),vjust=-0.25) +
  labs(title = "Average riding length/min", x = "Rider Type")

mean_plot

mode_plot <- ggplot(Ridelength_summary, aes(x= member_casual, y = mode , fill = rideable_type)) +
  geom_bar(position = "dodge",stat =  'identity') +
  geom_text(aes(label = mode), position = position_dodge(width=0.9), vjust=-0.25) +
  labs(title = "Mode riding length/min", x = "Rider Type")

mode_plot

Ridelength_summary %>%
  group_by(member_casual) %>%
  summarise(mean = mean(mean), max = max(max))

sql03 <- "
SELECT *
FROM CyclingData..weekday_table
"
weekday_info <- sqlQuery(dbcon, sql03)

View(weekday_info %>% arrange(member_casual, desc(count)))


weekday_plot <- 
  weekday_info %>% arrange(member_casual, desc(count)) %>%
  ggplot(aes(x =weekday_star, y = count, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_x_continuous("weekday", breaks = seq(1,7)) + scale_y_continuous(labels= scales :: comma_format(big.marks = ",")) +
  labs(title = "The number of riders on the day of a week (Sunday = 1)")


weekday_plot                        

-----------------------------------------------
  
sql04 <- "
SELECT *
FROM CyclingData..bikeTypeNum"

bikeTypeNum <- sqlQuery(dbcon, sql04)

bikeTypeNum

ggplot(bikeTypeNum %>% filter(member_casual == "member"), aes(x = '', y = bikeTypeNum, fill = rideable_type)) +
  geom_bar(stat = "identity") +
  coord_polar("y", start = 0) + theme_void()


bikeTypeNum_mem <- bikeTypeNum %>% 
  filter(member_casual == "member") %>%
  mutate (percentage = round(bikeTypeNum/sum(bikeTypeNum),digits = 2)*100)


pie_member <-
  ggplot(bikeTypeNum_mem, aes(x = '', y = percentage, fill = rideable_type)) +
  geom_bar(stat = "identity") +
  coord_polar("y", start = 0) + theme_void() +
  geom_text(aes(label = paste(percentage, "%")),
            position = position_stack(vjust = 0.5)) +
  labs(title = "Percentage of bikes used in the rides of members", subtitle = "Data from Aug 2020 to July 2021")

pie_member

bikeTypeNum_cas <- bikeTypeNum %>% 
  filter(member_casual == "casual") %>%
  mutate (percentage = round(bikeTypeNum/sum(bikeTypeNum),digits = 2)*100)

pie_casual <-
  ggplot(bikeTypeNum_cas, aes(x = '', y = percentage, fill = rideable_type)) +
  geom_bar(stat = "identity") +
  coord_polar("y", start = 0) + theme_void() +
  geom_text(aes(label = paste(percentage, "%")),
            position = position_stack(vjust = 0.5)) +
  labs(title = "Percentage of bikes used in the rides of casual riders", subtitle = "Data from Aug 2020 to July 2021")

pie_casual

