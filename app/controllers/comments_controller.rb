class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create ]

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
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
      params.require(:comment).permit(:content, :board_id)
    end
end
