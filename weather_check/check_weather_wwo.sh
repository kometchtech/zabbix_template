#!/bin/bash

APIKEY=""
URL="https://api.worldweatheronline.com/free/v2/weather.ashx?"
CURLOPTS="-s"
CITY=$1
WEATHER=$2
APIOPTS="&format=json&showlocaltime=yes&lang=ja&num_of_days=1&date=today&tp=1"
DATA=""


case $WEATHER in
	"weather")
		# Weather condition description
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
			jq -r ".data.current_condition[].lang_ja[].value"`
		echo $DATA
		;;
	"temp_C")
		# The temperature in degrees Celsius
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
            jq -r ".data.current_condition[].temp_C"`
		echo $DATA
		;;
	"humidity")
		# Humidity in percentage
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
     		jq -r ".data.current_condition[].humidity"`
		echo $DATA
		;;
	"cloudcover")
		# Cloud cover in percentage
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
            jq -r ".data.current_condition[].cloudcover"`
		echo $DATA
		;;
	"FeelsLikeC")
		# Sensory temperature
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
 			jq -r ".data.current_condition[].FeelsLikeC"`
		echo $DATA
		;;
	"pressure")
		# Atmospheric pressure in millibars
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
            jq -r ".data.current_condition[].pressure"`
		echo $DATA
		;;
	"precipMM")
		# Precipitation in millimetres
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
 			jq -r ".data.current_condition[].precipMM"`
		echo $DATA
		;;
	"winddir16Point")
		# Wind direction in 16-point compass
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
            jq -r ".data.current_condition[].winddir16Point"`
		echo $DATA
		;;
	"windspeedKmph")
		# Wind speed in kilometres per hour trans m/s
		DATA=`curl ${CURLOPTS} "${URL}q=${CITY}${APIOPTS}&key=${APIKEY}" | \
			 jq -r ".data.current_condition[].windspeedKmph"`
		echo "scale=1; ${DATA}/3.6" | bc
		;;
esac

