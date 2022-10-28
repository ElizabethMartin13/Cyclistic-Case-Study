# Cyclistic-Case-Study
Google Analytics Capstone Project using Cyclistic (Divvy) Bike Data

This Case Study was completed by Elizabeth Martin as part of the Google Data Analytics Professional Certificate. Excel, R, and Tableau were used to complete this case study and then hosted online through Git.

1. Objective (Ask Phase)
How do annual members and casual riders use Cyclistic Bikes differently? 
How can Cyclistic Bikes market towards casual riders to become annual members?  

    Business Task: To determine the differences in how annual members and casual riders use Cyclistic Bikes. Then to share this information with Lily Moreno, the Cyclistic marketing analytics team, as well as the Cyclistic Executive Team so that they can make an informed decision on how to market towards causal riders becoming annual members. 

2. Prepare Phase
The data used was Cyclistic’s historical trip data to analyze and identify trends from the previous 12 months. The data was downloaded directly from the Divvy Bikes website (https://divvy-tripdata.s3.amazonaws.com/index.html) and assumed to be credible as it was compiled and published by Cyclistic.  The data was downloaded and unzipped by months and saved individually in a worksheet.

    The data is licensed through Motivate International Inc. and is public data. https://ride.divvybikes.com/data-license-agreement

3. Process Phase
After importing the data, the first step was to check for any anomalies in the data. Open each file, add two new columns and hide the columns that were not needed.  Titled the two new columns as “ride_length” and “day_of_week”.  The formula in the “ride_length” column was =”ended_at” - “started_at”. This provided the ride length in time for all rider IDs. The formula in the “day_of_week” column was =WEEKDAY(C2,1)) (C2 is the first cell in the “started_at” column). The formulas were copy and pasted as values to secure the new data. Pivot tables were made for each month showing the number of rides for casual and member riders for each day. This was repeated for all 12 months. 
There were some anomalies in the data which are highlighted in the Cyclistic - Annual Members vs Casual Riders.pptx file.

4. Analyze Phase
The datasets were then uploaded to RStudio for further analysis. A full description of this process is described here: google_capstone_cyclistic_divvy_bikes.sql
In this phase, queries were created to uncover trends that were highlighted in the data visualizations created in Tableau.

5. Share Phase
Visualizations were created using Tableau. Published here https://public.tableau.com/views/google_cyclistic_divvy_bikes/Sheet1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link and included in the powerpoint presentation.

6. Act Phase
A powerpoint presentation was compiled - Cyclistic - Annual Members differ Casual Riders.pptx.
Google Analytics Capstone Project using Cyclistic (Divvy) bike data
