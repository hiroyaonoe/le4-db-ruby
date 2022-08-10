require 'rails_helper'

RSpec.describe "boards/edit", type: :view do
  before(:each) do
    @board = assign(:board, Board.create!(
      title: "MyString",
      user: nil,
      category: nil
    ))
  end

  it "renders the edit board form" do
    render

    assert_select "form[action=?][method=?]", board_path(@board), "post" do

      assert_select "input[name=?]", "board[title]"

      assert_select "input[name=?]", "board[user_id]"

      assert_select "input[name=?]", "board[category_id]"
    end
  end
end
