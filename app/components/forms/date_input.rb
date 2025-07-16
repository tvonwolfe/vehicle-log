module Components
  module Forms
    class DateInput < Base
      attr_reader :form, :param, :label, :opts

      def initialize(form:, param:, label: nil, **opts)
        @form = form
        @param = param
        @label = (label || param.to_s.titleize)
        @opts = opts
      end

      def view_template
        div id: "#{param}-input-container", class: "flex flex-col w-full", data: { controller: "input", input_target: "container" } do
          form.label param, label, class: "font-semibold text-slate-800 mb-1"

          form.date_field param, { class: "input-field input-normal", data: input_field_data, **opts }
        end
      end

      private

      def input_field_data
        @data ||= begin
          d = opts.delete(:data) || {}
          d.merge({ input_target: "input", action: "invalid->input#invalid input#changed" })
        end
      end
    end
  end
end
