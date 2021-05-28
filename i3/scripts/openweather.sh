#!/usr/bin/env bash

command -v jq >/dev/null 2>&1 || { echo >&2 "Program 'jq' required but it is not installed.  
Aborting."; exit 1; }
command -v wget >/dev/null 2>&1 || { echo >&2 "Program 'wget' required but is not installed.  
Aborting."; exit 1; }

APIKEY="51f13346767b5bce1cf7c034c9a39837"
#ZIPCODE="84321"
CITY_ID="5777544"
URL="http://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&units=imperial&APPID=${APIKEY}"

WEATHER_RESPONSE=$(wget -qO- "${URL}")

WEATHER_CONDITION=$(echo $WEATHER_RESPONSE | jq '.weather[0].main' | sed 's/"//g')
WEATHER_TEMP=$(echo $WEATHER_RESPONSE | jq '.main.temp')
WIND_DIR=$( echo "$WEATHER_RESPONSE" | jq '.wind.deg')
WIND_SPEED=$( echo "$WEATHER_RESPONSE" | jq '.wind.speed')

WIND_SPEED=$(awk "BEGIN {print 60*60*$WIND_SPEED/1000}")
WIND_DIR=$(awk "BEGIN {print int(($WIND_DIR % 360)/22.5)}")
DIR_ARRAY=( N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW N )
WIND_DIR=${DIR_ARRAY[WIND_DIR]}

case $WEATHER_CONDITION in
  'Clouds')
    WEATHER_ICON=""
    ;;
  'Rain')
    WEATHER_ICON=""
    ;;
  'Snow')
    WEATHER_ICON=""
    ;;
  *)
    WEATHER_ICON=""
    ;;
esac

echo "${WEATHER_ICON}  ${WEATHER_TEMP}°C: ${WIND_SPEED} km/h ${WIND_DIR}"
