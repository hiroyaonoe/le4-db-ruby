module UsersHelper
  def show_users_page?
    # TODO: もっとシンプルな方法探す
    (controller.controller_name == "users") && (controller.action_name == "show")
  end
end
