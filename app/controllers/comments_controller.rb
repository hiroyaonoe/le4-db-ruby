class CommentsController < ApplicationController

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @board = @comment.board
    respond_to do |format|
      if @comment.save
        format.html { redirect_to board_url(@board), notice: "Comment was successfully created." }
      else
        format.html { render "boards/show", status: :unprocessable_entity, location: board_url(@board) }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :board_id)
    end
end
