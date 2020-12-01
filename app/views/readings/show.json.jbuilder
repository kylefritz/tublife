def temps(records)
  Hash[records.pluck(["created_at", "temp_f"])]
end
def weather(city)
  {name: "Weather", data: temps(Weather.where(city: city)), color: "blue"}
end

def readings(device, color)
  {name: device, data: temps(Reading.where(device_name: device)), color: color}
end

def pump(device, color)
  data = Reading.where(device_name: device, pump: true).pluck(["created_at", "pump"]).map{|date, pump| [date, pump ? 95 : 0] }
  {name: device, data: Hash[data], color: color}
end

lucas_device = "ElizTUBeth Warmen"

json.baltimore [weather("Baltimore"), readings("Kale-a Lilly", "yellow"), readings("OBGTub", "green")]
json.richmond [weather("Richmond"), readings(lucas_device, "pink"), pump(lucas_device, "red")]
