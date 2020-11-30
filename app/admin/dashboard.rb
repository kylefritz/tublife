ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: "Reports" do
    columns do
      column do
        panel "Baltimore" do
          render WeatherComponent.new(city: "Baltimore")
          render TubChartComponent.new(device_name: "Kale-a Lilly")
          render TubChartComponent.new(device_name: "OBGTub")
        end
        panel "Richmond" do
          render WeatherComponent.new(city: "Richmond")
          render TubChartComponent.new(device_name: "Hot Tub Thermometer")
        end
      end
    end
  end

end
