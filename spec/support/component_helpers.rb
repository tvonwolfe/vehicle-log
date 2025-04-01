module ComponentHelpers
  def render(...)
    view_context.render(...)
  end

  def view_context = controller.view_context

  def controller = @controller ||= ActionView::TestCase::TestController.new
end
