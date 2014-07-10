# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
events = Event.create([
    { :name => 'Birthday Party', :event_date => Date.new(2014, 8, 8)},
    { :name => 'Wedding Reception', :event_date => Date.new(2014, 10, 13)}
])

('A'..'Z').each do |letter|
    events.each do |event|
        table = Table.create( :number => letter, :event => event, :max_seats => 12)
    end
end