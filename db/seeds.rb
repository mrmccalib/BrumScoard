# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

matthew = User.create(username: 'matthew', password: 'pass',           first: 'Matthew', last: "Lynch")
michael = User.create(username: 'michael', password: 'matthewiscool',  first: 'Michael', last: 'McCalib')
imax    = User.create(username: 'imax',   password: 'brumscoardrocks', first: 'Imax',    last: 'Rahal')
kenzie  = User.create(username: 'kenzie', password: 'greenhair',       first: 'Kenzie',  last: 'Flickinger')
haylie  = User.create(username: 'haylie', password: 'overwatchmemes',  first: 'Haylie',  last: 'Murphey')


testproject  = Board.create(name: 'testproject',  description: 'this is a test board')
cs330project = Board.create(name: 'CS330Project', description: 'board for CS330 project')

testsprint  = Sprint.create()
cs330sprint = Sprint.create()

testproject.sprints << testsprint
cs330project.sprints << cs330sprint

testpbl  = StoryColumn.create(name: 'Product Backlog', position: 0)
cs330pbl = StoryColumn.create(name: 'Product Backlog', position: 0)
testtodo  = TaskColumn.create(name: 'To Do', position: 2)
cs330todo = TaskColumn.create(name: 'To Do', position: 2)

testsprint.story_columns << testpbl
testsprint.story_columns << StoryColumn.create(name: 'Sprint Backlog', position:1)
testsprint.task_columns << testtodo
testsprint.task_columns << TaskColumn.create(name: 'Doing', position: 3)
testsprint.task_columns << TaskColumn.create(name: 'Done', position: 4)
cs330sprint.story_columns << cs330pbl
cs330sprint.story_columns << StoryColumn.create(name: 'Sprint Backlog', position: 1)
cs330sprint.task_columns << cs330todo
cs330sprint.task_columns << TaskColumn.create(name: 'Doing', position: 3)
cs330sprint.task_columns << TaskColumn.create(name: 'Done', position: 4)


story1 = Story.create(description: 'firstStory', as: 'Matthew', want: 'to stop coughing', so_that: 'I can stop bothering others',
      criteria: 'coughing no longer occurs ever', size: 'literally so small', position: 0)
story2 = Story.create(description: 'stuff happening', as: 'someone', want: 'some stuff', so_that: 'I can do some stuff',
    criteria: 'stuff is allowed to happen', size: 'not too big', position: 1)
story3 = Story.create(description: 'seed', as: 'a seed', want: 'water', so_that: 'I can do grow',
    criteria: 'I can do grow', size: 'a very big plant', position: 2)
story4 = Story.create(description: 'pringle', as: 'Julius Pringles', want: 'pringles', so_that: 'I have sustenance',
    criteria: 'pringles are provided', size: 'as many of them as possible', position: 3)
story5 = Story.create(description: 'scrum board', as: 'Imad', want: 'an entire scrum board', so_that: 'my students suffer',
    criteria: 'it has lots of features and styling is on fleek', size: 'tiny', position: 4)



task1 = Task.create(description: 'first Task!', weight: 20, position: 0)
task2 = Task.create(description: 'pop socket', weight: 30, position: 1)
task3 = Task.create(description: 'this was too creepy so I changed it', weight: 20, position: 2)
task4 = Task.create(description: 'bahamas is a set of islands in the carribean', weight: 50, position: 3)
task5 = Task.create(description: "orange juice has lots of vitamin c but really isn't very good for you",
    weight: 10, position: 4)
task6 = Task.create(description: 'lentil lasagna is a weight watchers recipe', weight: 30, position: 5)



cs330pbl.stories << story1
cs330pbl.stories << story2
cs330pbl.stories << story3
cs330pbl.stories << story4
cs330pbl.stories << story5

story1.tasks << task1
story1.tasks << task2
story1.tasks << task3
story2.tasks << task4
story2.tasks << task5
story2.tasks << task6

cs330todo.tasks << task1
cs330todo.tasks << task2
cs330todo.tasks << task3
cs330todo.tasks << task4
cs330todo.tasks << task5
cs330todo.tasks << task6

michael.tasks << task1
michael.tasks << task2
haylie.tasks << task3
haylie.tasks << task4
kenzie.tasks << task5
michael.tasks << task6


matthew.memberships.create(:board => cs330project, :role => :product_owner)
michael.memberships.create(:board => cs330project, :role => :developer)
haylie.memberships.create( :board => cs330project, :role => :developer)

michael.memberships.create(:board => testproject,  :role => :developer)
kenzie.memberships.create( :board => testproject,  :role => :developer)
imax.memberships.create(   :board => testproject,  :role => :product_owner)
matthew.invitations.create(:board => testproject,  :role => :developer)
