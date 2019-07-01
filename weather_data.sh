#!/bin/bash


#Parameter Initialization

START_TIME=$(date +"%x %r %Z")
processDate=$(date +%Y-%m-%d)
DIRPATH=/home/deepak/weather
City=$1
Country=$2
Retries=0
# Check if the cfg files exists in the path

if [ $# -eq 0 ]; then
 	exit 1
   	else

        . $DIRPATH/weather_data.cfg
	
	if [ $? -eq 0 ]; then
		FILE=$DIRPATH/weather_data.cfg
		CONF_FILE=$DIRPATH/weather_input.cfg
	else
		echo "Either Input parameter is incorrect or file $1.cfg file is not present in $DIRPATH.Please Check and rerun..aborting.">${LOG}
		exit 1
	fi
fi

#Function to Begin Script log capturing

BeginRunning()
{
    echo  "$START_TIME : ====== BEGIN THE PROGRAM : Weather_data.sh ========="> ${LOG}
}

#End Function

#Function to check if conf file is empty

doesFileExist()
{
    echo "Entering doesFileExist Function" >>${LOG}
   
	  if [ ! -s $FILE ] ; then
             echo "Input file is empty in the path.Please check ..aborting." >>${LOG}
             exit 1
         else
             echo "$FILE exist" >>${LOG}
    	  fi
}

#End Function

#Function to capture the end logs

EndRunning()
{
    echo "$END_TIME : ========= END OF THE PROGRAM : weather_data.sh ===========" >> ${LOG}
}

#End Function

BeginRunning;
doesFileExist;


#Fetch data from weather API
echo "Choose the file type to be downloaded (json/xml)" >>${LOG}
if [ $TYPE=="json" ]
then
	echo City=$City >>${LOG}
	echo Country=$Country >> ${LOG}
	echo FILE TYPE=$TYPE >> ${LOG}

while [ $Retries -lt 1 ]
do
	curl "http://api.openweathermap.org/data/2.5/weather?q=$City,$Country&APPID=$api_key" > weather_report.json
	if [ $? -eq 0 ]
	then
		echo "Connection sucessfull and weather data is downloaded sucessfully" >> ${LOG}
		
		#call python for json parsring
		python weather_info.py >result.csv
		echo "Displaying the data inside the csv file ">> ${LOG}
		cat result.csv >> ${LOG}
		echo "Weather data's are captured and sucessfully exported to csv file for furthur processing" >> ${LOG}
		echo "Execution completed sucessfully.Exiting gracefully.. !!" >>${LOG}
		exit 0
	else
		Retries=$( expr $Retries + 1 )
		echo "Retrying to reach the site" >> ${LOG}
		sleep 10
	fi
done
	echo "check the connection with OpenWeather API Site..Exiting" >> ${LOG}
	exit 1
fi
END_TIME=$(date +"%x %r %Z")
EndRunning;
