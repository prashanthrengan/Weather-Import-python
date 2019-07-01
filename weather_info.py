import json
from pprint import pprint

with open('weather_report.json') as data_file:    
    data = json.loads(data_file.read())

#pprint(data)

print "lon", "  ", "lat"," ","dt"," ", "humidity" , " " , "pressure" , " " , "temp" , " " , "temp_min" , " " , "temp_max" , " " , "name" , " " , "country" , " " , "speed"

print data["coord"]["lon"], "  " ,data["coord"]["lat"], " " ,data["dt"], " " ,data["main"]["humidity"], " " ,data["main"]["pressure"], " " ,data["main"]["temp"], " " ,data["main"]["temp_min"], " " ,data["main"]["temp_max"], " " ,data["name"], " " ,data["sys"]["country"], " " ,data["wind"]["speed"]


