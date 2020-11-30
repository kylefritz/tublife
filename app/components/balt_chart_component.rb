class BaltChartComponent < ViewComponent::Base
  def call
    weather = temps(Weather.where(city: "Baltimore"))
    tub_kale = temps(Reading.where(device_name: "Kale-a Lilly"))
    tub_obg = temps(Reading.where(device_name: "OBGTub"))

    id = ["temp", "balt"].join('-').parameterize
    data = [
      {name: "Weather", data: weather},
      {name: "Kale-a Lilly", data: tub_kale, color: "orange"},
      {name: "OBGTub", data: tub_obg, color: "green"},
    ]

    line_chart(
      data, id: id, min: 30, max:110,
      messages: {empty: "No history"},
      suffix: "°F"
    )
  end

  def temps(records)
    Hash[records.pluck(["created_at", "temp_f"])]
  end
end
