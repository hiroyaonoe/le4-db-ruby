class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create ]
  before_action :set_board, only: %i[ create ]


  # POST /boards/:board_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.board = @board
    respond_to do |format|
      if @comment.save
        format.html { redirect_to board_url(@board), notice: "Comment was successfully created." }
      else
        format.html { render "boards/show", status: :unprocessable_entity, location: board_url(@board) }
      end
    end
  end

  private
    def set_board
      @board = Board.find(params[:board_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
