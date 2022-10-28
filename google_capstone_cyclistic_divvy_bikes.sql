This is the R script used to import, compile and analyse the Cyclistic Case 
This study was completed for the Capstone Project of the Google Data Analytics Professional Certificate.

It uses the data from Divvy Bikes (https://www.divvybikes.com/system-data).

The steps followed:
1. Import and Load the seperate datasets
2. Combine all the data into one table
3. Clean Up and Add Data to Prepare for Analysis
4. Inspect, Identify, and Exclude data with anomalies
5. Create Data Visualisations

[Workspace loaded from ~/Desktop/CaseStudy/.RData]

> install.packages("tidyverse")
> install.packages("lubridate")
> library(tidyverse)
> library(lubridate)
> library(ggplot2)

----- 1. Import and Load the seperate datasets -----

> Sept_2021 <- read.csv("./combine/09_2021.csv")
> Oct_2021 <- read.csv("./combine/10_2021.csv")
> Nov_2021 <- read.csv("./combine/11_2021.csv")
> Dec_2021 <- read.csv("./combine/12_2021.csv")
> Jan_2022 <- read.csv("./combine/01_2022.csv")
> Feb_2022 <- read.csv("./combine/02_2022.csv")
> Mar_2022 <- read.csv("./combine/03_2022.csv")
> Apr_2022 <- read.csv("./combine/04_2022.csv")
> May_2022 <- read.csv("./combine/05_2022.csv")
> June_2022 <- read.csv("./combine/06_2022.csv")
> July_2022 <- read.csv("./combine/07_2022.csv")
> Aug_2022 <- read.csv("./combine/08_2022.csv")

> str(Sept_2021)
'data.frame':	756147 obs. of  15 variables:
 $ ride_id           : chr  "9DC7B962304CBFD8" "F930E2C6872D6B32" "6EF72137900BB910" "78D1DE133B3DBF55" ...
 $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
 $ started_at        : chr  "2021-09-28 16:07:10" "2021-09-28 14:24:51" "2021-09-28 00:20:16" "2021-09-28 14:51:17" ...
 $ ended_at          : chr  "2021-09-28 16:09:54" "2021-09-28 14:40:05" "2021-09-28 00:23:57" "2021-09-28 15:00:06" ...
 $ ride_length       : chr  "0:02:44" "0:15:14" "0:03:41" "0:08:49" ...
 $ day_of_week       : int  3 3 3 3 3 3 3 3 2 3 ...
 $ start_station_name: chr  "" "" "" "" ...
 $ start_station_id  : chr  "" "" "" "" ...
 $ end_station_name  : chr  "" "" "" "" ...
 $ end_station_id    : chr  "" "" "" "" ...
 $ start_lat         : num  41.9 41.9 41.8 41.8 41.9 ...
 $ start_lng         : num  -87.7 -87.6 -87.7 -87.7 -87.7 ...
 $ end_lat           : num  41.9 42 41.8 41.8 41.9 ...
 $ end_lng           : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...
 $ member_casual     : chr  "casual" "casual" "casual" "casual" ...

----- 2. Combine all the data into one table -----

> all_trips <- bind_rows(Sept_2021, Oct_2021, Nov_2021, Dec_2021, Jan_2022, Feb_2022, Mar_2022, Apr_2022, May_2022, June_2022, July_2022, Aug_2022)

----- 3. Clean Up and Add Data to Prepare for Analysis -----

> all_trips <- all_trips %>%  
+     select(-c(start_lat, start_lng, end_lat, end_lng,))

> str(all_trips)
'data.frame':	5883043 obs. of  11 variables:
 $ ride_id           : chr  "9DC7B962304CBFD8" "F930E2C6872D6B32" "6EF72137900BB910" "78D1DE133B3DBF55" ...
 $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
 $ started_at        : chr  "2021-09-28 16:07:10" "2021-09-28 14:24:51" "2021-09-28 00:20:16" "2021-09-28 14:51:17" ...
 $ ended_at          : chr  "2021-09-28 16:09:54" "2021-09-28 14:40:05" "2021-09-28 00:23:57" "2021-09-28 15:00:06" ...
 $ ride_length       : chr  "0:02:44" "0:15:14" "0:03:41" "0:08:49" ...
 $ day_of_week       : int  3 3 3 3 3 3 3 3 2 3 ...
 $ start_station_name: chr  "" "" "" "" ...
 $ start_station_id  : chr  "" "" "" "" ...
 $ end_station_name  : chr  "" "" "" "" ...
 $ end_station_id    : chr  "" "" "" "" ...
 $ member_casual     : chr  "casual" "casual" "casual" "casual" ...

> colnames(all_trips)
 [1] "ride_id"            "rideable_type"      "started_at"        
 [4] "ended_at"           "ride_length"        "day_of_week"       
 [7] "start_station_name" "start_station_id"   "end_station_name"  
[10] "end_station_id"     "member_casual"     

> nrow(all_trips)
[1] 5883043

> dim(all_trips)
[1] 5883043      11

> head(all_trips)
           ride_id rideable_type          started_at            ended_at
1 9DC7B962304CBFD8 electric_bike 2021-09-28 16:07:10 2021-09-28 16:09:54
2 F930E2C6872D6B32 electric_bike 2021-09-28 14:24:51 2021-09-28 14:40:05
3 6EF72137900BB910 electric_bike 2021-09-28 00:20:16 2021-09-28 00:23:57
4 78D1DE133B3DBF55 electric_bike 2021-09-28 14:51:17 2021-09-28 15:00:06
5 E03D4ACDCAEF6E00 electric_bike 2021-09-28 09:53:12 2021-09-28 10:03:44
6 346DE323A2677DC0 electric_bike 2021-09-28 01:53:18 2021-09-28 02:00:02
  ride_length day_of_week start_station_name start_station_id end_station_name
1     0:02:44           3                                                     
2     0:15:14           3                                                     
3     0:03:41           3                                                     
4     0:08:49           3                                                     
5     0:10:32           3                                                     
6     0:06:44           3                                                     
  end_station_id member_casual
1                       casual
2                       casual
3                       casual
4                       casual
5                       casual
6                       casual

> tail(all_trips)
                 ride_id rideable_type          started_at            ended_at
5883038 3A50755D869397FB electric_bike 2022-08-09 06:41:21 2022-08-09 06:45:22
5883039 EC17BE8AB1D73C88 electric_bike 2022-08-12 08:28:26 2022-08-12 08:42:26
5883040 57BAC0EA3A067A83 electric_bike 2022-08-22 12:30:19 2022-08-22 12:36:32
5883041 9B97FAE30276C299 electric_bike 2022-08-09 07:43:31 2022-08-09 07:50:50
5883042 2B4A9BA1E9AA9B51 electric_bike 2022-08-24 14:31:58 2022-08-24 14:40:32
5883043 7F0D048AC7C3B81A electric_bike 2022-08-24 09:45:04 2022-08-24 09:45:19
        ride_length day_of_week           start_station_name start_station_id
5883038     0:04:01           3 Ashland Ave & Wellington Ave            13269
5883039     0:14:00           6    Paulina St & Montrose Ave     TA1309000021
5883040     0:06:13           2     California Ave & 21st St            13096
5883041     0:07:19           3 Clinton St & Washington Blvd           WL-012
5883042     0:08:34           4 Ashland Ave & Wellington Ave            13269
5883043     0:00:15           4       Clark St & Lincoln Ave            13179
        end_station_name end_station_id member_casual
5883038                                        member
5883039                                        member
5883040                                        member
5883041                                        member
5883042                                        member
5883043                                        member

> summary(all_trips)
   ride_id          rideable_type       started_at          ended_at        
 Length:5883043     Length:5883043     Length:5883043     Length:5883043    
 Class :character   Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character   Mode  :character  
                                                                            
                                                                                                                                                  
 ride_length         day_of_week    start_station_name start_station_id  
 Length:5883043     Min.   :1.000   Length:5883043     Length:5883043    
 Class :character   1st Qu.:2.000   Class :character   Class :character  
 Mode  :character   Median :4.000   Mode  :character   Mode  :character  
                    Mean   :4.083                                        
                    3rd Qu.:6.000                                        
                    Max.   :7.000                                        
 end_station_name   end_station_id     member_casual     
 Length:5883043     Length:5883043     Length:5883043    
 Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character  
                                                                                                                  
                                                         
> table(all_trips$member_casual)

 casual  member 
2468479 3414564 

> all_trips$date <- as.Date(all_trips$started_at)

> all_trips$month <- format(as.Date(all_trips$date), "%m")

> all_trips$day <- format(as.Date(all_trips$date), "%d")

> all_trips$year <- format(as.Date(all_trips$date), "%Y")

> all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")

----- 4. Inspect, Identify, and Exclude data with anomalies -----

> str(all_trips)
'data.frame':	5883043 obs. of  15 variables:
 $ ride_id           : chr  "9DC7B962304CBFD8" "F930E2C6872D6B32" "6EF72137900BB910" "78D1DE133B3DBF55" ...
 $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
 $ started_at        : chr  "2021-09-28 16:07:10" "2021-09-28 14:24:51" "2021-09-28 00:20:16" "2021-09-28 14:51:17" ...
 $ ended_at          : chr  "2021-09-28 16:09:54" "2021-09-28 14:40:05" "2021-09-28 00:23:57" "2021-09-28 15:00:06" ...
 $ ride_length       : chr  "0:02:44" "0:15:14" "0:03:41" "0:08:49" ...
 $ day_of_week       : chr  "Tuesday" "Tuesday" "Tuesday" "Tuesday" ...
 $ start_station_name: chr  "" "" "" "" ...
 $ start_station_id  : chr  "" "" "" "" ...
 $ end_station_name  : chr  "" "" "" "" ...
 $ end_station_id    : chr  "" "" "" "" ...
 $ member_casual     : chr  "casual" "casual" "casual" "casual" ...
 $ date              : Date, format: "2021-09-28" "2021-09-28" ...
 $ month             : chr  "09" "09" "09" "09" ...
 $ day               : chr  "28" "28" "28" "28" ...
 $ year              : chr  "2021" "2021" "2021" "2021" ...

> all_trips$ride_length <- difftime(
+     all_trips$ended_at, 
+     all_trips$started_at,
+     units = "secs")

> str(all_trips)
'data.frame':	5883043 obs. of  15 variables:
 $ ride_id           : chr  "9DC7B962304CBFD8" "F930E2C6872D6B32" "6EF72137900BB910" "78D1DE133B3DBF55" ...
 $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
 $ started_at        : chr  "2021-09-28 16:07:10" "2021-09-28 14:24:51" "2021-09-28 00:20:16" "2021-09-28 14:51:17" ...
 $ ended_at          : chr  "2021-09-28 16:09:54" "2021-09-28 14:40:05" "2021-09-28 00:23:57" "2021-09-28 15:00:06" ...
 $ ride_length       : 'difftime' num  164 914 221 529 ...
  ..- attr(*, "units")= chr "secs"
 $ day_of_week       : chr  "Tuesday" "Tuesday" "Tuesday" "Tuesday" ...
 $ start_station_name: chr  "" "" "" "" ...
 $ start_station_id  : chr  "" "" "" "" ...
 $ end_station_name  : chr  "" "" "" "" ...
 $ end_station_id    : chr  "" "" "" "" ...
 $ member_casual     : chr  "casual" "casual" "casual" "casual" ...
 $ date              : Date, format: "2021-09-28" "2021-09-28" ...
 $ month             : chr  "09" "09" "09" "09" ...
 $ day               : chr  "28" "28" "28" "28" ...
 $ year              : chr  "2021" "2021" "2021" "2021" ...

> all_trips$ride_length <- as.numeric(
+     as.character(all_trips$ride_length))

> all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<0),]

> mean(all_trips_v2$ride_length)
[1] 1185.343

> median(all_trips_v2$ride_length)
[1] 643

> max(all_trips_v2$ride_length)
[1] 2442301

> min(all_trips_v2$ride_length)
[1] 0

> summary(all_trips_v2$ride_length)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0     363     643    1185    1160 2442301 
> aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
  all_trips_v2$member_casual all_trips_v2$ride_length
1                     casual                1758.0228
2                     member                 771.3398

> aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
  all_trips_v2$member_casual all_trips_v2$ride_length
1                     casual                      835
2                     member                      538

> aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
  all_trips_v2$member_casual all_trips_v2$ride_length
1                     casual                  2442301
2                     member                    89998

> aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)
  all_trips_v2$member_casual all_trips_v2$ride_length
1                     casual                        0
2                     member                        0

> aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
   all_trips_v2$member_casual all_trips_v2$day_of_week all_trips_v2$ride_length
1                      casual                   Friday                1673.3191
2                      member                   Friday                 755.6748
3                      casual                   Monday                1790.5689
4                      member                   Monday                 747.0105
5                      casual                 Saturday                1922.4518
6                      member                 Saturday                 858.1010
7                      casual                   Sunday                2051.8598
8                      member                   Sunday                 865.7101
9                      casual                 Thursday                1561.6087
10                     member                 Thursday                 742.4759
11                     casual                  Tuesday                1554.8980
12                     member                  Tuesday                 730.6850
13                     casual                Wednesday                1502.4496
14                     member                Wednesday                 731.7847

> all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

> aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
   all_trips_v2$member_casual all_trips_v2$day_of_week all_trips_v2$ride_length
1                      casual                   Sunday                2051.8598
2                      member                   Sunday                 865.7101
3                      casual                   Monday                1790.5689
4                      member                   Monday                 747.0105
5                      casual                  Tuesday                1554.8980
6                      member                  Tuesday                 730.6850
7                      casual                Wednesday                1502.4496
8                      member                Wednesday                 731.7847
9                      casual                 Thursday                1561.6087
10                     member                 Thursday                 742.4759
11                     casual                   Friday                1673.3191
12                     member                   Friday                 755.6748
13                     casual                 Saturday                1922.4518
14                     member                 Saturday                 858.1010

> all_trips_v2 %>% 
+     mutate(weekday = wday(started_at, label = TRUE))
            ride_id rideable_type          started_at            ended_at
1  9DC7B962304CBFD8 electric_bike 2021-09-28 16:07:10 2021-09-28 16:09:54
2  F930E2C6872D6B32 electric_bike 2021-09-28 14:24:51 2021-09-28 14:40:05
3  6EF72137900BB910 electric_bike 2021-09-28 00:20:16 2021-09-28 00:23:57
4  78D1DE133B3DBF55 electric_bike 2021-09-28 14:51:17 2021-09-28 15:00:06
5  E03D4ACDCAEF6E00 electric_bike 2021-09-28 09:53:12 2021-09-28 10:03:44
6  346DE323A2677DC0 electric_bike 2021-09-28 01:53:18 2021-09-28 02:00:02
7  558CE7087B42D8DB electric_bike 2021-09-28 07:15:56 2021-09-28 07:38:25
8  3EF7CB1851930A1F electric_bike 2021-09-28 11:17:00 2021-09-28 11:40:17
9  1F9A9A6BA4C2F82E electric_bike 2021-09-27 19:57:09 2021-09-27 20:09:08
10 CAA3791DE7300B8E electric_bike 2021-09-28 11:01:26 2021-09-28 11:22:56
11 CBFE6F6DE98B37BC electric_bike 2021-09-28 21:54:55 2021-09-28 22:02:49
12 FB63755F97C09F22 electric_bike 2021-09-28 21:19:12 2021-09-28 21:33:40
13 CDA1F01DF797DD01 electric_bike 2021-09-29 12:16:02 2021-09-29 12:27:02
14 3575930BD49A07EB electric_bike 2021-09-29 14:06:59 2021-09-29 14:07:25
15 ECDCF47EE3BF7F68 electric_bike 2021-09-11 23:26:03 2021-09-11 23:40:01
16 C7DFB8B3E78CF004 electric_bike 2021-09-11 19:17:26 2021-09-11 19:36:03
17 1945BF1C4BFB5E96 electric_bike 2021-09-08 12:48:40 2021-09-08 13:00:18
18 8E0C65BBC7771CBF electric_bike 2021-09-08 00:47:12 2021-09-08 00:56:04
19 BD04A1DD83063A44 electric_bike 2021-09-08 06:31:49 2021-09-08 07:21:46
20 526BB0814D176964 electric_bike 2021-09-08 05:54:37 2021-09-08 06:01:21
21 80D129A522452E03 electric_bike 2021-09-08 13:51:26 2021-09-08 14:11:31
22 C53D500E1D0EB696 electric_bike 2021-09-03 12:45:49 2021-09-03 12:57:47
23 BFDAB0C0957A30A9 electric_bike 2021-09-03 10:09:41 2021-09-03 10:34:21
24 2C1F6D5E0539E1C2 electric_bike 2021-09-02 21:39:25 2021-09-02 21:44:23
25 A7C9E0D00D96B0E6 electric_bike 2021-09-02 21:54:00 2021-09-02 22:05:24
26 79C8D3B0DD6BA60B electric_bike 2021-09-03 15:25:30 2021-09-03 15:40:15
27 62E81647CEEF07C4 electric_bike 2021-09-03 02:54:28 2021-09-03 03:22:21
28 DDF745D94653FFBB electric_bike 2021-09-02 23:13:48 2021-09-02 23:21:08
29 40766AF83549FFD2 electric_bike 2021-09-02 19:23:58 2021-09-02 19:54:32
30 69442D586F92CB70 electric_bike 2021-09-03 00:17:23 2021-09-03 01:35:24
31 67C7FEA78B9592AA electric_bike 2021-09-02 23:33:14 2021-09-03 00:00:48
32 B22E33AB81B065C1 electric_bike 2021-09-02 20:14:58 2021-09-02 20:34:11
33 C7A4056657A4BF83 electric_bike 2021-09-16 15:38:05 2021-09-16 15:53:44
34 AD5E2FE7E38A03BD electric_bike 2021-09-16 17:01:40 2021-09-16 17:10:20
35 2EA51C512EB88D6E electric_bike 2021-09-16 17:24:52 2021-09-16 17:43:09
36 3FAACFF17EF4A104 electric_bike 2021-09-16 07:11:46 2021-09-16 07:26:49
37 701A3052F4B2FC12 electric_bike 2021-09-16 04:20:02 2021-09-16 04:36:42
38 B291DEE28D900CC5 electric_bike 2021-09-15 21:59:06 2021-09-15 22:10:08
39 27892DEC21DAA167 electric_bike 2021-09-01 16:32:56 2021-09-01 16:49:38
40 0D38C4F3595DE07B electric_bike 2021-09-01 15:12:59 2021-09-01 15:28:53
41 715E00A17421B05F electric_bike 2021-09-01 15:35:38 2021-09-01 15:48:42
42 28A05B2EC20CB664 electric_bike 2021-09-01 02:16:04 2021-09-01 02:23:49
43 2F6F36A6174E5159 electric_bike 2021-09-01 01:29:32 2021-09-01 02:01:45
44 7018C2B77D71C83D electric_bike 2021-09-01 02:05:33 2021-09-01 02:12:21
45 4C001B97CD28F812 electric_bike 2021-09-01 11:05:12 2021-09-01 11:25:35
46 795770C349E61FED electric_bike 2021-09-01 00:18:55 2021-09-01 00:40:24
47 A8B22C2117327C33 electric_bike 2021-09-01 17:44:54 2021-09-01 17:48:47
48 DC92F26AA8682F47 electric_bike 2021-09-01 16:12:48 2021-09-01 17:41:33
49 016299A85E253637 electric_bike 2021-09-08 12:33:44 2021-09-08 12:37:41
50 7D012003BE5580C7 electric_bike 2021-09-08 06:23:58 2021-09-08 07:40:33
51 8A306A960FE6D900 electric_bike 2021-09-08 13:23:42 2021-09-08 13:24:19
52 12185A9F614DA493 electric_bike 2021-09-25 15:03:24 2021-09-25 15:17:37
53 FB92D36C44DB6BBA electric_bike 2021-09-25 03:34:13 2021-09-25 03:43:26
54 6546FBA2616EF388 electric_bike 2021-09-25 11:30:04 2021-09-25 11:45:40
55 057409D387E744E2 electric_bike 2021-09-25 09:12:45 2021-09-25 09:28:03
56 28AA967F1E4058C8 electric_bike 2021-09-25 07:59:23 2021-09-25 08:17:38
57 9116F6309B1B42FA electric_bike 2021-09-25 01:09:15 2021-09-25 01:14:40
58 66CC9D6C461D0906 electric_bike 2021-09-25 06:30:53 2021-09-25 06:36:20
59 3F9CB8C995D457A2 electric_bike 2021-09-06 14:34:46 2021-09-06 15:04:59
60 E92C804563F261EC  classic_bike 2021-09-05 01:25:08 2021-09-05 01:35:46
61 1841C04EEC71621A electric_bike 2021-09-05 10:41:52 2021-09-05 11:02:32
62 9ECA91210441E847  classic_bike 2021-09-05 13:33:41 2021-09-05 14:06:08
   ride_length day_of_week         start_station_name start_station_id
1          164     Tuesday                                            
2          914     Tuesday                                            
3          221     Tuesday                                            
4          529     Tuesday                                            
5          632     Tuesday                                            
6          404     Tuesday                                            
7         1349     Tuesday                                            
8         1397     Tuesday                                            
9          719      Monday                                            
10        1290     Tuesday                                            
11         474     Tuesday        Clark St & Grace St     TA1307000127
12         868     Tuesday                                            
13         660   Wednesday                                            
14          26   Wednesday                                            
15         838    Saturday                                            
16        1117    Saturday                                            
17         698   Wednesday                                            
18         532   Wednesday                                            
19        2997   Wednesday                                            
20         404   Wednesday                                            
21        1205   Wednesday                                            
22         718      Friday                                            
23        1480      Friday                                            
24         298    Thursday                                            
25         684    Thursday                                            
26         885      Friday                                            
27        1673      Friday                                            
28         440    Thursday                                            
29        1834    Thursday                                            
30        4681      Friday                                            
31        1654    Thursday                                            
32        1153    Thursday                                            
33         939    Thursday                                            
34         520    Thursday                                            
35        1097    Thursday                                            
36         903    Thursday                                            
37        1000    Thursday                                            
38         662   Wednesday                                            
39        1002   Wednesday                                            
40         954   Wednesday                                            
41         784   Wednesday                                            
42         465   Wednesday                                            
43        1933   Wednesday                                            
44         408   Wednesday                                            
45        1223   Wednesday                                            
46        1289   Wednesday                                            
47         233   Wednesday                                            
48        5325   Wednesday                                            
49         237   Wednesday                                            
50        4595   Wednesday                                            
51          37   Wednesday                                            
52         853    Saturday                                            
53         553    Saturday                                            
54         936    Saturday                                            
55         918    Saturday                                            
56        1095    Saturday                                            
57         325    Saturday                                            
58         327    Saturday                                            
59        1813      Monday                                            
60         638      Sunday       Wells St & Walton St     TA1306000011
61        1240      Sunday                                            
62        1947      Sunday Larrabee St & Armitage Ave     TA1309000006
            end_station_name end_station_id member_casual       date month day
1                                                  casual 2021-09-28    09  28
2                                                  casual 2021-09-28    09  28
3                                                  casual 2021-09-28    09  28
4                                                  casual 2021-09-28    09  28
5                                                  casual 2021-09-28    09  28
6                                                  casual 2021-09-28    09  28
7                                                  casual 2021-09-28    09  28
8                                                  casual 2021-09-28    09  28
9                                                  casual 2021-09-27    09  27
10                                                 casual 2021-09-28    09  28
11                                                 casual 2021-09-28    09  28
12                                                 casual 2021-09-28    09  28
13                                                 casual 2021-09-29    09  29
14                                                 casual 2021-09-29    09  29
15                                                 casual 2021-09-11    09  11
16                                                 casual 2021-09-11    09  11
17                                                 casual 2021-09-08    09  08
18                                                 casual 2021-09-08    09  08
19                                                 casual 2021-09-08    09  08
20                                                 casual 2021-09-08    09  08
21                                                 casual 2021-09-08    09  08
22                                                 casual 2021-09-03    09  03
23                                                 casual 2021-09-03    09  03
24                                                 casual 2021-09-02    09  02
25                                                 casual 2021-09-02    09  02
26                                                 casual 2021-09-03    09  03
27                                                 casual 2021-09-03    09  03
28                                                 casual 2021-09-02    09  02
29                                                 casual 2021-09-02    09  02
30                                                 casual 2021-09-03    09  03
31                                                 casual 2021-09-02    09  02
32                                                 casual 2021-09-02    09  02
33                                                 casual 2021-09-16    09  16
34                                                 casual 2021-09-16    09  16
35                                                 casual 2021-09-16    09  16
36                                                 casual 2021-09-16    09  16
37                                                 casual 2021-09-16    09  16
38                                                 casual 2021-09-15    09  15
39                                                 member 2021-09-01    09  01
40                                                 casual 2021-09-01    09  01
41                                                 casual 2021-09-01    09  01
42                                                 casual 2021-09-01    09  01
43                                                 casual 2021-09-01    09  01
44                                                 casual 2021-09-01    09  01
45                                                 casual 2021-09-01    09  01
46                                                 casual 2021-09-01    09  01
47                                                 casual 2021-09-01    09  01
48                                                 casual 2021-09-01    09  01
49                                                 casual 2021-09-08    09  08
50                                                 casual 2021-09-08    09  08
51                                                 casual 2021-09-08    09  08
52                                                 casual 2021-09-25    09  25
53                                                 casual 2021-09-25    09  25
54                                                 casual 2021-09-25    09  25
55                                                 casual 2021-09-25    09  25
56                                                 casual 2021-09-25    09  25
57                                                 casual 2021-09-25    09  25
58                                                 casual 2021-09-25    09  25
59                                                 casual 2021-09-06    09  06
60 Desplaines St & Kinzie St   TA1306000003        casual 2021-09-05    09  05
61                                                 casual 2021-09-05    09  05
62     Clark St & Leland Ave   TA1309000014        casual 2021-09-05    09  05
   year weekday
1  2021     Tue
2  2021     Tue
3  2021     Tue
4  2021     Tue
5  2021     Tue
6  2021     Tue
7  2021     Tue
8  2021     Tue
9  2021     Mon
10 2021     Tue
11 2021     Tue
12 2021     Tue
13 2021     Wed
14 2021     Wed
15 2021     Sat
16 2021     Sat
17 2021     Wed
18 2021     Wed
19 2021     Wed
20 2021     Wed
21 2021     Wed
22 2021     Fri
23 2021     Fri
24 2021     Thu
25 2021     Thu
26 2021     Fri
27 2021     Fri
28 2021     Thu
29 2021     Thu
30 2021     Fri
31 2021     Thu
32 2021     Thu
33 2021     Thu
34 2021     Thu
35 2021     Thu
36 2021     Thu
37 2021     Thu
38 2021     Wed
39 2021     Wed
40 2021     Wed
41 2021     Wed
42 2021     Wed
43 2021     Wed
44 2021     Wed
45 2021     Wed
46 2021     Wed
47 2021     Wed
48 2021     Wed
49 2021     Wed
50 2021     Wed
51 2021     Wed
52 2021     Sat
53 2021     Sat
54 2021     Sat
55 2021     Sat
56 2021     Sat
57 2021     Sat
58 2021     Sat
59 2021     Mon
60 2021     Sun
61 2021     Sun
62 2021     Sun
 [ reached 'max' / getOption("max.print") -- omitted 5882846 rows ]

> all_trips_v2 %>% 
+     mutate(weekday = wday(started_at, label = TRUE)) %>%
+     group_by(member_casual, weekday) %>%  
+     summarise(number_of_rides = n()	,average_duration = mean(ride_length)) %>%
+ arrange(member_casual, weekday)
#`summarise()` has grouped output by 'member_casual'. You can override using the
#`.groups` argument.
# A tibble: 14 × 4
# Groups:   member_casual [2]
   member_casual weekday number_of_rides average_duration
   <chr>         <ord>             <int>            <dbl>
 1 casual        Sun              437413            2052.
 2 casual        Mon              292181            1791.
 3 casual        Tue              278007            1555.
 4 casual        Wed              293245            1502.
 5 casual        Thu              311487            1562.
 6 casual        Fri              346025            1673.
 7 casual        Sat              510057            1922.
 8 member        Sun              404503             866.
 9 member        Mon              474817             747.
10 member        Tue              536485             731.
11 member        Wed              547011             732.
12 member        Thu              525483             742.
13 member        Fri              472179             756.
14 member        Sat              454015             858.

----- 5. Create Data Visualisations -----

> all_trips_v2 %>% 
+     mutate(weekday = wday(started_at, label = TRUE)) %>% 
+     group_by(member_casual, weekday) %>% 
+     summarise(number_of_rides = n()
+               ,average_duration = mean(ride_length)) %>% 
+     arrange(member_casual, weekday)  %>% 
+     ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) + geom_col(position = "dodge")
#`summarise()` has grouped output by 'member_casual'. You can override using the
#`.groups` argument.

> all_trips_v2 %>% 
+     mutate(weekday = wday(started_at, label = TRUE)) %>% 
+     group_by(member_casual, weekday) %>% 
+     summarise(number_of_rides = n()
+               ,average_duration = mean(ride_length)) %>% 
+     arrange(member_casual, weekday)  %>% 
+     ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
+     geom_col(position = "dodge")
#`summarise()` has grouped output by 'member_casual'. You can override using the
#`.groups` argument.

Save the plot graphs as images to be used in presentation
