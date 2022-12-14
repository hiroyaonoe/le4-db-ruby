class BoardsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create destroy ]
  before_action :set_board, only: %i[ show edit update destroy ]

  # GET /boards/1
  def show
    @comment = Comment.new
  end

  # POST /boards
  def create
    @board = Board.new(board_params)
    @board.user= current_user
    @board.tags= tag_names.map do |name|
      Tag.find_or_create_by(name: name)
    end

    @boards = Board.latest
    respond_to do |format|
      if @board.save
        format.html { redirect_to board_url(@board), notice: "Board was successfully created." }
      else
        @categories = Category.all
        @tags = Tag.all
        format.html { render "static_pages/home", status: :unprocessable_entity, location: root_url }
      end
    end
  end

  # DELETE /boards/1
  def destroy
    @comment = Comment.new
    if (current_user.has_board? @board) || current_user.admin? || current_user.owner?
      @board.destroy
      respond_to do |format|
        format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
      end
    else
      respond_to do |format|
        format.html { render :show, status: :unauthorized }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:title, :category_id)
    end

    def tag_names
      params.require(:board)[:tag_text].split
    end
end
