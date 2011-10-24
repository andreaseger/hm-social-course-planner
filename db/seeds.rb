# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Day.create!( name: 'mo', label: 'Montag' )
Day.create!( name: 'di', label: 'Dienstag' )
Day.create!( name: 'mi', label: 'Mittwoch' )
Day.create!( name: 'do', label: 'Donnerstag' )
Day.create!( name: 'fr', label: 'Freitag' )
