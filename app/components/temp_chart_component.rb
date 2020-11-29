class TempChartComponent < ViewComponent::Base
  def initialize(location:, device_name:)
    @location = location
    @device_name = device_name
  end

  def readings
    data = Hash[Reading.where(device_name: @device_name).pluck(["created_at", "temp_f"])]
    line_chart([{name: @device_name, data: data}], min: "95", max: "108", id: "temp-#{@location}",)
  end

end
