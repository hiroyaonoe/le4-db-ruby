class SearchController < ApplicationController
  
  # POST /search
  def index
    @boards = Board.find_category(category_id).like_title(words)
    @comments = Comment.like_content(words)
    @categories = Category.form_select_params
  end

  private
    def words
      if params.has_key? :words
        params[:words].split
      else
        []
      end
    end

    def category_id
      if params.has_key? :category_id
        params[:category_id]
      else
        Board::ALL
      end
    end
end
