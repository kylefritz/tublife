class TubChartComponent < ViewComponent::Base
  def initialize(city:, device_name:)
    @device_name = device_name
    @city = city
  end

  def call
    weather = temps(Weather.where(city: @city))
    tub_temp = temps(Reading.where(device_name: @device_name))
    tub_pump = Hash[Reading.where(device_name: @device_name, pump: true).pluck(["created_at", "pump"]).map{|date, pump| [date, pump ? 95 : 0] }]

    id = ["temp", @city, @device_name].join('-').parameterize
    data = [
      {name: "Weather", data: weather},
      {name: @device_name, data: tub_temp, color: "pink"},
      {name: "Pump", data: tub_pump, color: "red"},
    ]

    line_chart(
      data,
      id: id, min: 30, max:110,
      messages: {empty: "No history for #{@device_name}"},
      suffix: "°F"
    )
  end

  def temps(records)
    Hash[records.pluck(["created_at", "temp_f"])]
  end
end
