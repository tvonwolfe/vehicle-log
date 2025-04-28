module Components
  module Forms
    class ErrorMessage < Base
      attr_reader :error

      def initialize(error:)
        @error = error
      end

      def view_template
        div data: { testid: "error-message" }, class: "flex gap-1 text-red-700 text-lg font-semibold" do
          span { raw safe("&#9888;")  }
          p { error }
        end
      end
    end
  end
end
