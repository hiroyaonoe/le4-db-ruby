class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :boards
  has_many :comments
  validates :name, presence: true
  enum :role, { member: 0, admin: 1, owner: 2 }

  def has_board?(board)
    board.user.id.equal?(self.id)
  end
end
