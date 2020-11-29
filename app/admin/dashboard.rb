ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: "Reports" do
    columns do
      column do
        def readings(device_name)
          data = Hash[Reading.where(device_name: device_name).pluck(["created_at", "temp_f"])]
          line_chart([{name: device_name, data: data}], min: "95", max: "108")
        end

        panel "Baltimore" do
          readings("Kale-a Lilly")
        end
        panel "Richmond" do
          readings("Hot Tub Thermometer")
        end
      end
    end
  end

end
