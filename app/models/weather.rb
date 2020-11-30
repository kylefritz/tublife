API_URL = "http://api.openweathermap.org/data/2.5"

class Weather < ApplicationRecord
  def self.for!(city)
    weather_data = download("weather?q=#{city},us")
    temp = weather_data.main.temp
    # weather_data.main.feels_like

    Weather.create!(city: city, temp_f: temp)
  end

  def self.history!(city, lat, lon, weather_at)
    weather_data = download("onecall/timemachine?lat=#{lat}&lon=#{lon}&type=hour&dt=#{weather_at.to_i}")

    temp = weather_data.current.temp
    Weather.create!(city: city, temp_f: temp, created_at: weather_at)
  end

  def self.download(url)
    api_key = ENV['OPEN_WEATHER_KEY']
    throw "Missing OPEN_WEATHER_KEY from env" if !api_key

    url = "#{API_URL}/#{url}&units=imperial&appid=#{api_key}"
    puts url
    raw_data = Faraday.get(url).body
    JSON.parse(raw_data, object_class: OpenStruct)
  end
end
