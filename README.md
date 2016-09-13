# ChartChamp
Data and Code used to build the dashboard for ChartChamp 2016

Dashboard Title:  Districts punching above their weight (Finding MA districts with high SAT scores and low house prices)

Acknowledgements: Professor Jeffrey Shaffer for teaching me tableau and data visualization. My boss Vishwa & my colleagues at John Hancock Insurance & my family for their support and encouragement. 

Data Used:
•	SAT data from dataset provided
•	Crime data from neighborhood scout ( https://www.neighborhoodscout.com/ma/crime/) using import.io for automated web scrapping
•	House pricing data from Zillow (http://www.zillow.com/research/data/)

Tools Used: Excel, Microsoft SQL Server for data blending, import.io for web scrapping, R for exploratory data analysis, Photoshop for background image modification and Tableau 10.0 for dashboarding.
Introduction: House prices in an area are driven up by good school districts. In this dashboard we test this assumption by comparing districts based on their average house prices and their average SAT scores. We find certain districts have high SAT scores but low house prices (and vice-versa). We also look at factors which might be driving (or be the result) of these discrepancies. 

Method: All the data was imported in SQL server  and blended before use. Districts were ranked by their house prices and SAT scores to create a Sankey chart. Districts with the biggest difference between average SAT ranking and average House Price rankings were identified and marked. This data was imported in R for exploratory data analysis. Correlation analysis and Gradient Boosting Machines (GBM) revealed top factors which could be contributing to this difference (smaller towns with low crime and low government funding but good qualified teachers). Certain factors (like ‘# of teachers evaluated’,etc.) were not used because they were highly correlated with district population.

Visualization: A classroom chalkboard was used as background and all fonts/ colors/graphs were selected according to the theme. We employ Sankey charts (energy flow diagrams), filled maps and shape charts for our analysis. Further, we use ‘parameter based sheet selector’ method to view multiple maps on the dashboard.
Inference: A few districts have good SAT ranks and low House prices. This may be driven by:
-	Located further away from Boston, have a small population with low crime rates 
-	Receive small government funding 
-	Have a lot of qualified teachers teaching in core areas (important)
-	Teachers tend to be as popular with students irrespective of where they live (in MA)

About the author:
Shatrunjai Singh
Senior Data Scientist, John Hancock Insurance 
Email: shatrunjai@gmail.com
http://www.shatrunjai.com/    https://www.linkedin.com/in/shatrunjai  https://github.com/shatrunjai

