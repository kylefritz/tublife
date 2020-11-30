ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: "Reports" do
    columns do
      column do
        panel "Baltimore" do
          render BaltChartComponent.new
        end
        panel "Richmond" do
          render TubChartComponent.new(city: "Richmond", device_name: "ElizTUBeth Warmen")
        end
      end
    end
  end

end
