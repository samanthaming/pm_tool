# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

2.times do
  project = Project.create  title: Faker::Hipster.sentence(4),
                  description: Faker::Hipster.paragraph,
                  due_date: Faker::Date.forward(50)

  2.times do
    Task.create  title: Faker::Book.title,
                 body: Faker::Hacker.say_something_smart,
                 due_date: Faker::Date.forward(100),
                 project: project

  end

end
