class CreateWeathers < ActiveRecord::Migration[6.0]
  def change
    create_table :weathers do |t|
      t.string :city
      t.decimal :temp_f, precision: 8, scale: 2, null: false

      t.datetime :created_at, null: false
    end

    remove_column(:readings, :updated_at, :datetime, null: false)
  end
end
