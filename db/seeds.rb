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


testproject = Board.create(name: 'testproject', description: 'this is a test board')
cs330project = Board.create(name: 'CS330Project', description: 'board for CS330 project')


story1 = Story.create(description: 'firstStory', as: 'Matthew', want: 'to stop coughing', so_that: 'I can stop bothering others',
      criteria: 'coughing no longer occurs ever', size: 'literally so small', position: 0, column: 0)
story2 = Story.create(description: 'stuff happening', as: 'someone', want: 'some stuff', so_that: 'I can do some stuff',
    criteria: 'stuff is allowed to happen', size: 'not too big', position: 1, column: 0)
story3 = Story.create(description: 'seed', as: 'a seed', want: 'water', so_that: 'I can do grow',
    criteria: 'I can do grow', size: 'a very big plant', position: 2, column: 0)
story4 = Story.create(description: 'pringle', as: 'Julius Pringles', want: 'pringles', so_that: 'I have sustenance',
    criteria: 'pringles are provided', size: 'as many of them as possible', position: 3, column: 0)
story5 = Story.create(description: 'scrum board', as: 'Imad', want: 'an entire scrum board', so_that: 'my students suffer',
    criteria: 'it has lots of features and styling is on fleek', size: 'tiny', position: 4, column: 0)




cs330project.stories << story1
cs330project.stories << story2
cs330project.stories << story3
cs330project.stories << story4
cs330project.stories << story5

# matthew.boards << board
# michael.boards << board

matthew.memberships.create(:board => cs330project, :role => :product_owner)
michael.memberships.create(:board => cs330project, :role => :developer)

michael.memberships.create(:board => testproject, :role => :developer)
matthew.invitations.create(:board => testproject, :role => :developer)
