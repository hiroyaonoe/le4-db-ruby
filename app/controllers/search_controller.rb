class SearchController < ApplicationController
  
  # POST /search
  def index
    @boards = Board.like_title(words)
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
end
