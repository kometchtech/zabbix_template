#!/bin/bash

# http://openweathermap.org/current
CITY=$1
WEATHER=$2
CURLURL="http://api.openweathermap.org/data/2.5/weather?q="
CURLOPTS="-m 30 --retry 10 -s"
APIKEY=""
DATA=""

function weatherCode() {
	case $1 in
		# Thunderstorm
		200)
			echo "小雨と雷雨"
			;;
		201)
			echo "雨と雷雨"
			;;
		202)
			echo "大雨と雷雨"
			;;
		210)
			echo "光雷雨"
			;;
		211)
			echo "雷雨"
			;;
		212)
			echo "激しい雷雨"
			;;
		221)
			echo "ぼろぼろの雷雨"
			;;
		230)
			echo "小雨と雷雨"
			;;
		231)
			echo "霧雨と雷雨"
			;;
		232)
			echo "激しい霧雨と雷雨"
			;;
		# Drizzle
		300)
			echo "光強度霧雨"
			;;
		301)
			echo "霧雨"
			;;
		302)
			echo "激しい霧雨" 
			;;
		310)
			echo "光強度霧雨の雨"
			;;
		311)
			echo "霧雨のような雨"
			;;
		312)
			echo "激しい霧雨の雨"
			;;
		313)
			echo "霧雨の雨"
			;;
		314)
			echo "激しいシャワーの雨と霧雨"
			;;
		321)
			echo "シャワー霧雨"
			;;
		# Rain
		500)
			echo "小雨"
			;;
		501)
			echo "適度な雨"
			;;
		502)
			echo "激しい強度の雨"
			;;
		503)
			echo "非常に激しい雨"
			;;
		504)
			echo "極端な雨"
			;;
		511)
			echo "雨氷"
			;;
		520)
			echo "光強度のシャワーの雨"
			;;
		521)
			echo "シャワーの雨"
			;;
		522)
			echo "激しいシャワーの雨"
			;;
		531)
			echo "不規則なシャワーの雨"
			;;
		# snow
		600)
			echo "小雪"
			;;
		601)
			echo "雪"
			;;
		602)
			echo "大雪"
			;;
		611)
			echo "みぞれ"
			;;
		612)
			echo "シャワーみぞれ"
			;;
		615)
			echo "光雨と雪"
			;;
		616)
			echo "雨や雪"
			;;
		620)
			echo "光のシャワー雪"
			;;
		621)
			echo "シャワー雪"
			;;
		622)
			echo "激しいシャワー雪"
			;;
		# Atmosphere
		701)
			echo "ミスト"
			;;
		711)
			echo "煙"
			;;
		721)
			echo "ヘイズ"
			;;
		731)
			echo "砂、ほこり旋風"
			;;
		741)
			echo "霧"
			;;
		751)
			echo "砂"
			;;
		761)
			echo "ほこり"
			;;
		762)
			echo "火山灰"
			;;
		771)
			echo "スコール"
			;;
		781)
			echo "竜巻"
			;;
		800)
			echo "晴天"
			;;
		801)
			echo "少し曇り"
			;;
		802)
			echo "曇り"
			;;
		803)
			echo "やや曇り"
			;;
		804)
			echo "どんよりした曇"
			;;
		
	esac
}		

function windDegree() {
	degree=$1
	degree=`echo $degree \* 10000 | bc` > /dev/null 2>&1
	degree=${degree%.*}
	if [ ${degree} -gt "2250000" ]; then
		degree=`expr ${degree} + 3600000`
	fi

	if [ 225000 -lt $degree -a $degree -le 675000 ]; then
		echo "北東"
	elif [ 675000 -lt $degree -a $degree -le 1125000 ]; then
		echo "東"
	elif [ 1125000 -lt $degree -a $degree -le 1575000 ]; then
		echo "南東"
	elif [ 1575000 -lt $degree -a $degree -le 2025000 ]; then
		echo "南"
	elif [ 2025000 -lt $degree -a $degree -le 2475000 ]; then
		echo "南西"
	elif [ 2475000 -lt $degree -a $degree -le 2925000 ]; then
		echo "西"
	elif [ 2925000 -lt $degree -a $degree -le 3375000 ]; then
		echo "北西"
	elif [ 3375000 -lt $degree -a $degree -le 3825000 ]; then
		echo "北"
	fi
}

case $WEATHER in
	"weather")
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
        	weatherCode `echo ${DATA} | jq .weather[0].id`
		;;
	"sunrise")
		# Sunrise time, unix, UTC
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
		DATA=`echo ${DATA} | jq .jq .sys.sunrise`
		echo `date --date "@${DATA}"`
		;;
	"sunset")
		# Sunset time, unix, UTC
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
		DATA=`echo ${DATA} | jq .sys.sunset`
		echo `date --date "@${DATA}"`
		;;
	"humidity")
		# Humidity, %
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
		echo `echo ${DATA} | jq .main.humidity`
		;;
	"grnd_level")
		# Atmospheric pressure on the ground level, hPa
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
		echo `echo ${DATA} | jq .main.grnd_level`
		;;
	"sea_level")
		# Atmospheric pressure on the sea level, hPa
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
        echo `echo ${DATA} | jq .main.sea_level`
		;;
	"pressure")
		# Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
        echo `echo ${DATA} | jq .main.pressure`
		;;
	"temp_max")
		# Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
		echo `echo ${DATA} | jq .main.temp_max`
		;;
	"temp_min")
		# Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
        echo `echo ${DATA} | jq .main.temp_min`
		;;
	"temp")
		# Temperature, Kelvin (subtract 273.15 to convert to Celsius)
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
		echo `echo ${DATA} | jq .main.temp`
		;;
	"deg")
		# Wind direction, degrees (meteorological)
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
		windDegree `echo ${DATA} | jq .wind.deg`
		;;
	"speed")
		# Wind speed, mps
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
		echo `echo ${DATA} | jq .wind.speed`
		;;
	"clouds")
		# Cloudiness, %
		while [ "$DATA" = "" -o "$DATA" = "failed to connect " ]
		do
			DATA=`curl ${CURLOPTS} "${CURLURL}${CITY}&APPID=${APIKEY}"\&units=metric`
		done
        echo `echo ${DATA} | jq .clouds.all`
		;;
esac

