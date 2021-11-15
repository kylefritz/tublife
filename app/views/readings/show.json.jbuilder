def temps(records)
  records.pluck(["created_at", "temp_f"])
end

def weather(city)
  {name: "Weather", data: temps(Weather.where(city: city).order(:created_at)), color: "blue"}
end

def readings(device, color)
  {name: device, data: temps(Reading.where(device_name: device).order(:created_at)), color: color}
end

json.baltimore [weather("Baltimore"), readings("East Tub", "yellow"), readings("West Tub", "purple")]

# lucas
json.richmond [weather("Richmond"), readings("Good Soup", "green")]
