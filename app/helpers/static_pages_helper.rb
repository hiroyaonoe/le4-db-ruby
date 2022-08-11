module StaticPagesHelper
  def root_page?
    # TODO: もっとシンプルな方法探す
    (controller.controller_name == "static_pages") && (controller.action_name == "home")
  end
end
