namespace :db do
    desc "Loads new instruments from config/initializers/artist_instruments_constants.rb into database"
    task :add_instruments => :environment do

        for instrument_name in ARTIST_INSTRUMENTS
            if Instrument.where(name: instrument_name).count == 0
                Instrument.create!(name: instrument_name)
                puts "new instrument: #{instrument_name}"
            end
        end

        puts "Total of #{Instrument.count} instruments"
    end
end