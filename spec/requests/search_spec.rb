require 'rails_helper'

RSpec.describe "Searches", type: :request do
  let(:member1) { create(:user, :member) }
  let(:category1) { create(:category) }
  describe "GET /search" do
    before(:each) do
      create(:board, title: "abcde", user_id: member1.id, category_id: category1.id)
      create(:board, title: "cdefg", user_id: member1.id, category_id: category1.id)
      create(:board, title: "efghi", user_id: member1.id, category_id: category1.id)
      create(:board, title: "ghijk", user_id: member1.id, category_id: category1.id)
      create(:board, title: "ddddd", user_id: member1.id, category_id: create(:category).id)
    end

    context "with one word" do
      context "with category" do
        it "hits correct boards" do
          get search_index_url, params: { words: "d", category_id: category1.id }
          expect(response.body).to include "abcde"
          expect(response.body).to include "cdefg"
          expect(response.body).not_to include "efghi"
          expect(response.body).not_to include "ghijk"
          expect(response.body).not_to include "ddddd"
        end

        it "renders a successful response" do
          get search_index_url, params: { words: "d", category_id: category1.id }
          expect(response).to be_successful
        end
      end

      context "with no category" do
        it "hits correct boards" do
          get search_index_url, params: { words: "d" }
          expect(response.body).to include "abcde"
          expect(response.body).to include "cdefg"
          expect(response.body).not_to include "efghi"
          expect(response.body).not_to include "ghijk"
          expect(response.body).to include "ddddd"
        end

        it "renders a successful response" do
          get search_index_url, params: { words: "d" }
          expect(response).to be_successful
        end
      end
    end

    context "with two words" do
      it "hits correct boards" do
        get search_index_url, params: { words: "d a" }
        expect(response.body).to include "abcde"
        expect(response.body).not_to include "cdefg"
        expect(response.body).not_to include "efghi"
        expect(response.body).not_to include "ghijk"
        expect(response.body).not_to include "ddddd"
      end

      it "renders a successful response" do
        get search_index_url, params: { words: "d k" }
        expect(response).to be_successful
      end
    end

    context "with blank word" do
      it "hits correct boards" do
        get search_index_url, params: { words: " " }
        expect(response.body).to include "abcde"
        expect(response.body).to include "cdefg"
        expect(response.body).to include "efghi"
        expect(response.body).to include "ghijk"
        expect(response.body).to include "ddddd"
      end

      it "renders a successful response" do
        get search_index_url, params: { words: " " }
        expect(response).to be_successful
      end
    end

    context "with no words" do
      context "with category" do
        it "hits correct boards" do
          get search_index_url, params: { category_id: category1.id }
          expect(response.body).to include "abcde"
          expect(response.body).to include "cdefg"
          expect(response.body).to include "efghi"
          expect(response.body).to include "ghijk"
          expect(response.body).not_to include "ddddd"
        end

        it "renders a successful response" do
          get search_index_url, params: { category_id: category1.id }
          expect(response).to be_successful
        end
      end

      context "with no category" do
        it "hits correct boards" do
          get search_index_url
          expect(response.body).to include "abcde"
          expect(response.body).to include "cdefg"
          expect(response.body).to include "efghi"
          expect(response.body).to include "ghijk"
          expect(response.body).to include "ddddd"
        end
  
        it "renders a successful response" do
          get search_index_url
          expect(response).to be_successful
        end
      end
    end
  end
end
