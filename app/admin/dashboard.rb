ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: "Reports" do
    columns do
      column do
        panel "Baltimore" do
          render TubChartComponent.new(device_name: "Kale-a Lilly")
        end
        panel "Richmond" do
          render TubChartComponent.new(device_name: "Hot Tub Thermometer")
        end
      end
    end
  end

end
