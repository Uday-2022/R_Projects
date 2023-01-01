# install packages tidyverse for importing data, piping commands
install.packages("tidyverse")
install.packages("rio") # to import excel files
install.packages("party") # for decision tree
if (!require("pacman")) install.packages("pacman")

#load pre installed package
library(tidyverse, rio)
pacman::p_load(pacman,party, rio, tidyverse)

#import GDP and its components excel file using rio package function import
df_constant <- import("C:/Users/91981/Desktop/Uday/Personal_analysis_projects/Git_projects/RBI_GDP_Componets_Market_Price_yearly.xlsx")%>%
  as_tibble()%>%
  select(Year_FY, GDP_market_prices_constant,
         Private_final_consumption_expenditure_constant, Government_final_consumption_expenditure_constant,
         Gross_fixed_capital_formation_constant, Changes_in_stocks_constant, Valuables_constant,
         Exports_Goods_and_Services_constant, Import_Goods_and_Services_constant, Discrepancies_constant)%>%
  mutate(
    Net_Exports_constant = Exports_Goods_and_Services_constant - Import_Goods_and_Services_constant,
    Investment_constant  = Gross_fixed_capital_formation_constant + Changes_in_stocks_constant)%>%
  print(n = Inf)

df_constant_2015 <- df_constant[1:65,]

summary(df_constant_2015)

plot(
  df_constant_2015$Year_FY,
  df_constant_2015$GDP_market_prices_constant,
    main = "GDP and its components (Both Constant and Current Rs in Crores)",
    sub  = "(Source: RBI)",
    xlab = "Year",
    ylab = "GDP and its components",
    #pch="o",
    #lty=1
  )
lines(df_constant_2015$Year_FY,
      df_constant_2015$GDP_market_prices_constant, col = 2)

lines(df_constant_2015$Year_FY,
      df_constant_2015$Private_final_consumption_expenditure_constant, col = 3)

lines(df_constant_2015$Year_FY,
      df_constant_2015$Investment_constant, col = 4)


lines(df_constant_2015$Year_FY,
      df_constant_2015$Government_final_consumption_expenditure_constant, col = 5)

lines(df_constant_2015$Year_FY,
      df_constant_2015$Net_Exports_constant, col = 6)

lines(df_constant_2015$Year_FY,
      df_constant_2015$Valuables_constant, col = 7)

lines(df_constant_2015$Year_FY,
      df_constant_2015$Discrepancies_constant, col = 8)
