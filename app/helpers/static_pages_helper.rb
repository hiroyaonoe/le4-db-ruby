module StaticPagesHelper
  def root?
    # TODO: もっとシンプルな方法探す
    (controller.controller_name == "static_pages") && (controller.action_name == "home")
  end
end
