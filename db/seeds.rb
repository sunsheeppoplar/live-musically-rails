# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

start = Time.now
i = 1

while i < 501 do
	employer = User.create!(email: "e#{i}@e.com", password: "password", password_confirmation: "password", role: "artist_employer", first_name: "Employer #{i} First Name", last_name: "Employer #{i} Last Name")
	opp = employer.employing_opportunities.create!(
		title: "Superbowl Shenanigans #{i}",
		description: "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.",
		event_start_date: DateTime.now.beginning_of_hour + 1.month,
		event_end_date: DateTime.now.beginning_of_hour + 1.month + 4.hours,
		timeframe_of_post: DateTime.now.beginning_of_hour + 1.month + 4.hours,
	)
	# 2208 is count of locations in NY with our data
	location = Location.where(state: "NY")[rand(0..2208)]
	opp.create_venue!(
		name: "Bar #{i}",
		address: "#{i} Index Avenue",
		city: location.city || "Brooklyn",
		state: "NY",
		zip: location.zipcode || "11238",
		category: rand(0..5)
	)
	opp.artist_opportunities.create!(artist_type: ARTIST_INSTRUMENTS[rand(1..107)])

	puts "#{i} seeds created"

	i += 1
end

finish = Time.now

puts "\nIt took #{finish - start} seconds to seed db"