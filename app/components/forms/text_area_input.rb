module Components
  module Forms
    class TextAreaInput < Base
      attr_reader :form, :param, :label, :opts

      def initialize(form:, param:, label: nil, **opts)
        @form = form
        @param = param
        @label = (label || param.to_s.titleize)
        @opts = opts
      end

      def view_template
        div id: "#{param}-input-container", class: "flex flex-col w-full" do
          form.label param, label, class: "font-semibold text-slate-800 mb-1"
          form.textarea param, { class: "input-field input-normal", **opts }
        end
      end
    end
  end
end
