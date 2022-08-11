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
board1 = Board.create({ title: "Board1", user: member1, category: category1 })
Comment.create([{ content: "comment1", user: member1, board: board1 }, { content: "comment2", user: member1, board: board1 }, { content: "comment3", user: member2, board: board1 }])
