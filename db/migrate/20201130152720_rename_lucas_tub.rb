class RenameLucasTub < ActiveRecord::Migration[6.0]
  def up
    Reading.where(device_name: "Hot Tub Thermometer").update_all(device_name: "ElizTUBeth Warmen")
  end
  def down
  end
end
