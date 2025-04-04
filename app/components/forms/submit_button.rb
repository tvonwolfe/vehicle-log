module Components
  module Forms
    class SubmitButton < Base
      def initialize(form:, cta_text:)
        @form = form
        @cta_text = cta_text
      end

      def view_template
        div class: "mb-4 mt-8 sm:mt-4 flex justify-end" do
          form.submit(
            cta_text,
            id: "submit-button",
            class: "w-full sm:w-auto h-10 px-4 rounded-sm font-semibold text-white bg-slate-600 hover:cursor-pointer hover:bg-slate-700 transition-colors",
            data: { form_target: "submit" }
          )
        end
      end

      private

      attr_reader :cta_text, :form
    end
  end
end
