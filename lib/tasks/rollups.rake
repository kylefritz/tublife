namespace :rollups do
    desc "rollup the old rows & truncate db"
    task rollup_and_truncate: :environment do
        Weather.group(:city)
               .rollup('weather.city.daily') { |r| r.median(:temp_f) }
        Reading.group(:device_name)
               .rollup('reading.device_name.daily') { |r| r.median(:temp_f) }

        Weather.where("created_at < NOW() - INTERVAL '48 HOURS'").delete_all
        Reading.where("created_at < NOW() - INTERVAL '48 HOURS'").delete_all
    end
  end
  