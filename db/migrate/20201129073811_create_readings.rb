class CreateReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :readings do |t|
      t.string :device_name, null: false
      t.decimal :temp_f, precision: 8, scale: 2, null: false
      t.boolean :pump, null: false

      t.timestamps
    end
  end
end
