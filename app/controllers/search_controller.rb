class SearchController < ApplicationController
  
  # POST /search
  def index
    @boards = Board.where_tags(tag_ids).find_category(category_id).like_title(words)
    @comments = Comment.find_category(category_id).like_content(words)
    @categories = Category.all
    @tags = Tag.all
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
    
    def tag_ids
      if params.has_key? :tag_ids
        array = params[:tag_ids]
        array.delete("")
        array
      else
        []
      end
    end
end
