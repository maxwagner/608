# About

***

### Overview

Track and field record progression has hit a relative ceiling in human performance. Until the 1970's, records progressed smoothly. The 1970's and 1980's featured rampant drug abuse with minimal regulation. Many of the records set in that time period have not been broken.

### Doping and Drug Abuse

It is common knowledge that doping occurs in competitive sports, but the extent to which it was practiced prior to competent monitoring is often overlooked. A more prominant example is East Germany in the late 1970's and 1980's. More recently, a state sponsored program was uncovered in Russia. The effect the abuse had goes beyond medals and records, and moves into human rights, informed consent, and other human justice problems. An extensive report on the East German doping can be found [here.](http://clinchem.aaccjnls.org/content/43/7/1262)

### Data

The IAAF (International Association of Athletics Federations) has accurate archives of meet performances reaching back to the 1960's, with further, but less accurate measurements into the 1800's. The simplicity of record keeping for track and field keeps the number of variables low, but results from before the 1960's suffer from inconsistant timing and often hand timed results. Performances from before that era will not be used, as their influence on results was minimal.

### Variables

* **Mark**: Mark is measured in various ways. For sprinting events, it is measured in seconds. For mid distance events, it is measured in minutes:seconds.tenths. For the long distance events it is measured in hours:minutes:seconds. For field events, it is measured in meters, either length of height. For the purposes of graphing and comparison, all units shown will be in decimals. 

* **Athlete**: Simply the name of the competitor that completed the mark.

* **Nation**: The nationality of the athlete.

* **Venue**: Where the mark was completed.

* **Date**: The date the mark was completed.

* **Sex**: The sex of the athlete.

* **Event**: The event in which the mark was completed.

### Data Aquisition and Cleaning

All data was obtained from the IAAF's archives which can be found [here.](https://www.iaaf.org/records/toplists/sprints/100-metres/outdoor/men/senior) Each event's information was copied from its respective page, and then cleaned and transformed using the script found [here](https://github.com/maxwagner/608/blob/master/final/cleaning/cleaning.R) and secondarily [here.](https://github.com/maxwagner/608/blob/master/final/cleaning/getrecords.R)

Each individual file was read in, and stripped of extra information. Only the top 100 times by any athlete were taken from each event for consistancy. Each event file was then added to one large file containing all events for later processing. 

In the secondary file, the sprints, mid distance, distance, and field events were separted, as their variables behave slightly differently. The `Mark` variable was transformed into a decimal representation in order to be properly graphed and compared.
