class TubChartComponent < ViewComponent::Base
  def initialize(device_name:)
    @device_name = device_name
  end

  def readings
    temp_data = Hash[Reading.where(device_name: @device_name).pluck(["created_at", "temp_f"])]
    pump_data = Hash[Reading.where(device_name: @device_name, pump: true).pluck(["created_at", "pump"]).map{|date, pump| [date, pump ? 95 : 0] }]
    id = ["temp", @device_name].join('-').parameterize
    line_chart([
      {name: @device_name, data: temp_data},
      {name: "Pump", data: pump_data}
    ], min: "95", max: "108", id: id,)
  end

end
