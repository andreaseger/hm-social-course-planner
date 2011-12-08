# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Day.create!( id: 1, name: 'mo', label: 'Montag' )
Day.create!( id: 2, name: 'di', label: 'Dienstag' )
Day.create!( id: 3, name: 'mi', label: 'Mittwoch' )
Day.create!( id: 4, name: 'do', label: 'Donnerstag' )
Day.create!( id: 5, name: 'fr', label: 'Freitag' )
