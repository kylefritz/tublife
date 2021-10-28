class AddSummaryToReadings < ActiveRecord::Migration[6.0]
  def change
    add_column :readings, :summary, :boolean, default: false, null: false
    add_column :weathers, :summary, :boolean, default: false, null: false
  end
end
