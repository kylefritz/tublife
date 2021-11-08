def temps(records)
  records.pluck(["created_at", "temp_f"])
end

def weather(city)
  {name: "Weather", data: temps(Weather.where(city: city).order(:created_at)), color: "blue"}
end

def readings(device, color)
  {name: device, data: temps(Reading.where(device_name: device).order(:created_at)), color: color}
end

def pump(device, color)
  data = Reading.where(device_name: device).order(:created_at).pluck(["created_at", "pump"]).map{|date, pump| [date, pump ? 95 : 0] }
  {name: "Pump", data: data, color: color}
end

lucas_device = "ElizTUBeth Warmen"

json.baltimore [weather("Baltimore"), readings("East Tub", "yellow"), readings("West Tub", "purple")]
json.richmond [weather("Richmond"), readings(lucas_device, "purple"), pump(lucas_device, "red")]
