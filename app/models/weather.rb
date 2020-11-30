API_URL = "http://api.openweathermap.org/data/2.5"

class Weather < ApplicationRecord
  def self.for!(city)
    api_key = ENV['OPEN_WEATHER_KEY']
    if !api_key
      throw "Missing OPEN_WEATHER_KEY from env"
    end

    raw_data = Faraday.get("#{API_URL}/weather?q=#{city},us&units=imperial&APPID=#{api_key}").body
    weather_data = JSON.parse(raw_data, object_class: OpenStruct)

    temp = weather_data.main.temp
    # weather_data.main.feels_like

    Weather.create!(city: city, temp_f: temp)
  end
end
