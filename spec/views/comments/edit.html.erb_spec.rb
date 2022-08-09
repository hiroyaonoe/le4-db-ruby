require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      content: "MyText",
      board_id: 1,
      user_id: 1
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "textarea[name=?]", "comment[content]"

      assert_select "input[name=?]", "comment[board_id]"

      assert_select "input[name=?]", "comment[user_id]"
    end
  end
end
