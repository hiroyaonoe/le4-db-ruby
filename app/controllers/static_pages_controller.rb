class StaticPagesController < ApplicationController
  def home
    @board = Board.new
    @boards = Board.latest
    @categories = Category.form_select_params
  end
end
