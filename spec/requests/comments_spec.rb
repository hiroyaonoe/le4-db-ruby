require 'rails_helper'

RSpec.describe "Comments", type: :request do
  
  let(:user) { create(:user) }
  let(:board) { create(:board) }
  let(:valid_attributes) {
    attributes_for(:comment, board_id: board.id, user_id: user.id)
  }

  let(:invalid_attributes) {
    attributes_for(:comment, board_id: board.id)
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comments" do
        expect {
          post comments_url, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the created comment" do
        post comments_url, params: { comment: valid_attributes }
        expect(response).to redirect_to(board_url(board))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post comments_url, params: { comment: invalid_attributes }
        }.to change(Comment, :count).by(0)
      end

      it "return a 422 response" do
        post comments_url, params: { comment: invalid_attributes }
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
