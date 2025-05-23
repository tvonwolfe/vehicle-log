module Components
  class Link < Base
    include Phlex::Rails::Helpers::LinkTo

    attr_reader :href, :text

    def initialize(href:, text: nil)
      @href = href
      @text = text || href
    end

    def view_template
      span(class: "flex") do
        link_to text, href, class: "text-slate-500 hover:underline font-semibold"
      end
    end
  end
end
