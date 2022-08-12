# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

member1 = User.create({ name: "Member1", email: "member1@example.com", password: "password", role: :member})
member2 = User.create({ name: "Member2", email: "member2@example.com", password: "password", role: :member})
admin1 = User.create({ name: "Admin2", email: "admin1@example.com", password: "password", role: :admin})
owner1 = User.create({ name: "Owner2", email: "owner1@example.com", password: "password", role: :owner})
category1 = Category.create({ name: "Category1" })

boards = []
(1..10).each do |i|
  boards.push({ title: "Board-#{i}-1", user: member1, category: category1 })
  boards.push({ title: "Board-#{i}-2", user: member2, category: category1 })
  boards.push({ title: "Board-#{i}-3", user: admin1, category: category1 })
  boards.push({ title: "Board-#{i}-4", user: owner1, category: category1 })
end
Board.create(boards)

board1 = Board.create({ title: "Board-main", user: member1, category: category1 })

comments = []
(1..5).each do |i|
  comments.push({ content: "comment-#{i}-1", user: member1, board: board1 })
  comments.push({ content: "comment-#{i}-2", user: member2, board: board1 })
end
Comment.create(comments)
