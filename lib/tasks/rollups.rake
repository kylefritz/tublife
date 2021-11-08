namespace :rollups do
    desc "rollup the old rows & truncate db"
    task rollup_and_truncate: :environment do
        ["Baltimore", "Richmond"].each do |city|
            Weather.where(city: city).rollup(city) { |r| r.median(:temp_f) }
        end

        ["East Tub", "West Tub"].each do |device|
            Reading.where(device_name: device).rollup(device) { |r| r.median(:temp_f) }
        end

        Weather.where("created_at < NOW() - INTERVAL '48 HOURS'").delete_all
        Reading.where("created_at < NOW() - INTERVAL '48 HOURS'").delete_all
    end
  end
  