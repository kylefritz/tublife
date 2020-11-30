class WeatherComponent < ViewComponent::Base
  def initialize(city:)
    @city = city
  end

  def call
    temp_data = Hash[Weather.where(city: @city).pluck(["created_at", "temp_f"])]

    id = ["temp", @city].join('-').parameterize
    data = [
      {name: @city, data: temp_data}
    ]

    line_chart(
      data,
      id: id, height: "150px", legend: false,
      messages: {empty: "No history for #{@city}"},
      suffix: "°F"
    )
  end
end
