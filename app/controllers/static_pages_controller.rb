class StaticPagesController < ApplicationController
  def home
    @board = Board.new
    @boards = Board.latest
    @categories = Category.all
  end
end
