module Views
  module SignUps
    class Success < Base
      def initialize(user:)
        @user = user
      end

      def view_template
        div class: "mt-8" do
          h1 class: "font-bold text-3xl sm:text-center text-green-800" do
            "Success"
          end

          p class: "text-lg sm:text-xl sm:text-center" do
            plain "A confirmation email has been sent to "
            strong { user.email_address }
            plain "."
          end
        end
      end

      private

      attr_reader :user
    end
  end
end
