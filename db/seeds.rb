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

boards = 10.times.flat_map do |i|
  category = Category.create({ name: "category-#{i}" })
  tag = Tag.create({ name: "tag-#{i}" })
  [
    { title: "Board-#{i}-1", user: member1, category: category, tags: [ tag ] },
    { title: "Board-#{i}-2", user: member2, category: category, tags: [ tag ] },
    { title: "Board-#{i}-3", user: admin1, category: category, tags: [ tag ] },
    { title: "Board-#{i}-4", user: owner1, category: category, tags: [ tag ] }
  ]
end
Board.create(boards)

category1 = Category.create({ name: "Category-main" })
board1 = Board.create({ title: "Board-main", user: member1, category: category1 })

comments = 5.times.flat_map do |i|
  [
    { content: "comment-#{i}-1", user: member1, board: board1 },
    { content: "comment-#{i}-2", user: member2, board: board1 }
  ]
end
Comment.create(comments)

tags = 3.times.map do |i|
  Tag.find_or_create_by(name: "tag-#{i}")
end
board1.update(tags: tags)
