class TubChartComponent < ViewComponent::Base
  def initialize(device_name:)
    @device_name = device_name
  end

  def call
    temp_data = Hash[Reading.where(device_name: @device_name).pluck(["created_at", "temp_f"])]
    pump_data = Hash[Reading.where(device_name: @device_name, pump: true).pluck(["created_at", "pump"]).map{|date, pump| [date, pump ? 95 : 0] }]

    min = [temp_data.values.min, 95].compact.min
    max = [temp_data.values.max, 108].compact.max

    id = ["temp", @device_name].join('-').parameterize
    data = [
      {name: @device_name, data: temp_data},
      {name: "Pump", data: pump_data},
    ]

    line_chart(
      data,
      id: id, min: min, max: max,
      messages: {empty: "No history for #{@device_name}"},
      suffix: "°F"
    )
  end
end
