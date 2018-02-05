namespace :db do
    desc "Loads db/formatted_usa_zips.sql into database and then updates db/schema.rb"
    task add_locations: []  do
        rails db < db/formatted_usa_zips.sql
        rails db:migrate
    end
end