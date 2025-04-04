module Components
  class LinkButton < Base
    attr_reader :href, :text

    def initialize(text:, href:)
      @text = text
      @href = href
    end

    def view_template
      a href:, class: "rounded py-2 px-4 font-semibold text-white bg-slate-700 hover:bg-slate-600 transition transition-color" do
        text
      end
    end
  end
end
