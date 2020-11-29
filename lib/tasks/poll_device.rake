namespace :poll_device do
  desc "poll device & save values to db"
  task poll: :environment do
    comand = "#{ Rails.root }/bin/temp-check"
    # puts comand

    json = `#{comand}`
    puts json

    attrs = JSON.parse(json)
    # puts attrs

    Reading.create!(attrs)
  end
end