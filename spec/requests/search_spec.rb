require 'rails_helper'

RSpec.describe "Searches", type: :request do
  let(:member1) { create(:user, :member) }
  let(:category1) { create(:category) }
  let(:tag1) { create(:tag) }
  let(:tag2) { create(:tag) }
  describe "GET /search" do
    describe "board" do
      context "with no tags" do
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

      context "with tags" do
        before(:each) do
          board1 = create(:board, title: "xxxxx", user_id: member1.id, category_id: category1.id)
          create(:board_tag, tag_id: tag1.id, board_id: board1.id)
          create(:board_tag, tag_id: tag2.id, board_id: board1.id)
          create(:board_tag, 
            tag_id: tag1.id,
            board_id: create(:board, title: "yyyyy", user_id: member1.id, category_id: category1.id).id
          )
          create(:board, title: "zzzzz", user_id: member1.id, category_id: category1.id)
        end
        context "(one)" do
          it "hits correct boards" do
            get search_index_url, params: { tag_ids: [tag1.id] }
            expect(response.body).to include "xxxxx"
            expect(response.body).to include "yyyyy"
            expect(response.body).not_to include "zzzzz"
          end

          it "renders a successful response" do
            get search_index_url, params: { tag_ids: [tag1.id] }
            expect(response).to be_successful
          end
        end
        context "(two)" do
          it "hits correct boards" do
            get search_index_url, params: { tag_ids: [tag1.id, tag2.id] }
            expect(response.body).to include "xxxxx"
            expect(response.body).not_to include "yyyyy"
            expect(response.body).not_to include "zzzzz"
          end

          it "renders a successful response" do
            get search_index_url, params: { tag_ids: [tag1.id, tag2.id] }
            expect(response).to be_successful
          end
        end
        context "(zero)" do
          it "hits correct boards" do
            get search_index_url, params: { tag_ids: [""] }
            expect(response.body).to include "xxxxx"
            expect(response.body).to include "yyyyy"
            expect(response.body).to include "zzzzz"
          end

          it "renders a successful response" do
            get search_index_url, params: { tag_ids: [""] }
            expect(response).to be_successful
          end
        end
        context "(blank)" do
          it "hits correct boards" do
            get search_index_url
            expect(response.body).to include "xxxxx"
            expect(response.body).to include "yyyyy"
            expect(response.body).to include "zzzzz"
          end

          it "renders a successful response" do
            get search_index_url
            expect(response).to be_successful
          end
        end
      end
    end

    describe "comment" do
      let(:board1) { create(:board, title: "board1", user_id: member1.id, category_id: category1.id) }
      let(:board2) { create(:board, title: "board1", user_id: member1.id, category_id: create(:category).id) }
      before(:each) do
        create(:comment, content: "abcde", user_id: member1.id, board_id: board1.id)
        create(:comment, content: "cdefg", user_id: member1.id, board_id: board1.id)
        create(:comment, content: "efghi", user_id: member1.id, board_id: board1.id)
        create(:comment, content: "ghijk", user_id: member1.id, board_id: board1.id)
        create(:comment, content: "ddddd", user_id: member1.id, board_id: board2.id)
      end

      context "with one word" do
        context "with category" do
          it "hits correct comments" do
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
          it "hits correct comments" do
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
        it "hits correct comments" do
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
        it "hits correct comments" do
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
          it "hits correct comments" do
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

        context "with blank category" do
          it "hits correct comments" do
            get search_index_url, params: { category_id: "" }
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

        context "with no category" do
          it "hits correct comments" do
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
end
