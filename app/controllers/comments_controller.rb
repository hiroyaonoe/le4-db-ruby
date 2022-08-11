class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create ]

  # POST /boards/:board_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.board_id = board_id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to board_url(board_id), notice: "Comment was successfully created." }
      else
        format.html { render "boards/show", status: :unprocessable_entity, location: board_url(board_id) }
      end
    end
  end

  private
    def board_id
      params[:board_id]
    end
    def comment_params
      params.require(:comment).permit(:content)
    end
end
