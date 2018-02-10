namespace :db do
    desc "Loads db/formatted_usa_zips.sql into database and then updates db/schema.rb"
    task :add_locations => :environment do
        if Location.count == 0
            system("rails db < db/formatted_usa_zips.sql")
        else
            puts "ZIPCODES ALREADY EXIST"
        end
    end
end