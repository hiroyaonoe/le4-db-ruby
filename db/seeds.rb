# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create({ name: "User1" })
category1 = Category.create({ name: "Category1" })
board1 = Board.create({ title: "Board1", user: user1, category: category1 })
Comment.create([{ content: "comment1", user: user1, board: board1 }, { content: "comment2", user: user1, board: board1 }])
