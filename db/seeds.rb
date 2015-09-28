# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.where(email: 'admin@example.com').exists?
  user = User.create!({
    first_name: 'active',
    last_name: 'admin', 
    email: 'admin@example.com',
    password: 'password',
    role: 'admin'
  })
end

