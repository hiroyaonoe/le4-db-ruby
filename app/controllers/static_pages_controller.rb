class StaticPagesController < ApplicationController
  def home
    @board = Board.new
    @boards = Board.latest
    @categories = Category.all
    @tags = Tag.all
  end
end
