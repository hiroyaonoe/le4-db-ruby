class StaticPagesController < ApplicationController
  def home
    @board = Board.new
    @boards = Board.latest
  end
end
