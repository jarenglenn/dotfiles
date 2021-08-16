#!/bin/sh

get_icon() {
    case $1 in
        # Icons for weather-icons
        01d) icon="%{T5}%{T-}";;
        01n) icon="%{T5}%{T-}";;
        02d) icon="%{T5}%{T-}";;
        02n) icon="%{T5}%{T-}";;
        03*) icon="%{T5}%{T-}";;
        04*) icon="%{T5}%{T-}";;
        09d) icon="%{T5}%{T-}";;
        09n) icon="%{T5}%{T-}";;
        10d) icon="%{T5}%{T-}";;
        10n) icon="%{T5}%{T-}";;
        11d) icon="%{T5}%{T-}";;
        11n) icon="%{T5}%{T-}";;
        13d) icon="%{T5}%{T-}";;
        13n) icon="%{T5}%{T-}";;
        50d) icon="%{T5}%{T-}";;
        50n) icon="%{T5}%{T-}";;
        *) icon="%{T5}%{T-}";

        # Icons for Font Awesome 5 Pro
        #01d) icon="";;
        #01n) icon="";;
        #02d) icon="";;
        #02n) icon="";;
        #03d) icon="";;
        #03n) icon="";;
        #04*) icon="";;
        #09*) icon="";;
        #10d) icon="";;
        #10n) icon="";;
        #11*) icon="";;
        #13*) icon="";;
        #50*) icon="";;
        #*) icon="";
    esac

    echo $icon
}

KEY="51f13346767b5bce1cf7c034c9a39837"
CITY="5777544"
UNITS="imperial"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

    echo "$(get_icon "$weather_icon")" "$weather_temp$SYMBOL"
fi
