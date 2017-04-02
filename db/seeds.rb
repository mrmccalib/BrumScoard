# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

matthew = User.create(username: 'matthew', password: 'pass', first: 'Matthew', last: "Lynch")
michael = User.create(username: 'michael', password: 'matthewiscool', first: 'Michael', last: 'McCalib')
User.create(username: 'imax', password: 'brumscoardrocks', first: 'Imax', last: 'Rahal')
User.create(username: 'kenzie', password: 'greenhair', first: 'Kenzie', last: 'Flickinger')
User.create(username: 'haylie', password: 'overwatchmemes', first: 'Haylie', last: 'Murphey')


Board.create(name: 'testproject', description: 'this is a test board')
board = Board.create(name: 'CS330Project', description: 'board for CS330 project')


story = Story.create(description: 'firstStory', as: 'Matthew', want: 'to stop coughing', so_that: 'I can stop bothering others',
      criteria: 'coughing no longer occurs ever', size: 'literally so small')

board.stories << story
matthew.boards << board
michael.boards << board
