require 'rails_helper'

RSpec.describe "Comments", type: :request do
  
  let(:user) { create(:user, :member) }
  let(:board) { create(:board) }
  let(:valid_attributes) {
    attributes_for(:comment)
  }

  let(:invalid_attributes) {
    attributes_for(:comment, content: "")
  }

  describe "POST /create" do
    context "when logined" do
      before(:each) do
        sign_in user
      end

      context "with valid parameters" do
        it "creates a new Comments" do
          expect {
            post board_comments_url(board), params: { comment: valid_attributes }
          }.to change(Comment, :count).by(1)
        end

        it "redirects to the created comment" do
          post board_comments_url(board), params: { comment: valid_attributes }
          expect(response).to redirect_to(board_url(board))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Comment" do
          expect {
            post board_comments_url(board), params: { comment: invalid_attributes }
          }.to change(Comment, :count).by(0)
        end

        it "return a 422 response" do
          post board_comments_url(board), params: { comment: invalid_attributes }
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end

    context "when not logined" do
      context "with valid parameters" do
        it "does not creates a new Comments" do
          expect {
            post board_comments_url(board), params: { comment: valid_attributes }
          }.to change(Comment, :count).by(0)
        end

        it "redirects to the login" do
          post board_comments_url(board), params: { comment: valid_attributes }
          expect(response).to redirect_to(new_user_session_url)
        end
      end
    end
  end
end
