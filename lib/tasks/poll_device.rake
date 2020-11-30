namespace :poll_device do
  desc "poll device & save values to db"
  task poll: :environment do
    comand = "#{ Rails.root }/bin/temp-check"
    # puts comand

    json = `#{comand}`
    puts json

    attrs_list = JSON.parse(json)
    # puts attrs

    attrs_list.each do |attrs|
      Reading.create!(attrs)
    end

    Weather.for!("Baltimore")
    Weather.for!("Richmond")
  end
end
