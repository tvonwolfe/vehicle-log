module Views
  module Sessions
    class SignIn < Base
      include Phlex::Rails::Helpers::FormWith
      include Phlex::Rails::Helpers::LinkTo

      def initialize(email_address: nil, error: nil, notice: nil)
        @email_address = email_address
        @error = error
        @notice = notice
      end

      def view_template
        render Components::Header

        div(
          id: "signin-form",
          class: "w-full sm:max-w-lg sm:mx-auto sm:mt-10 \
                  sm:border sm:rounded sm:p-5 md:p-10 sm:shadow-lg \
                  sm:border sm:border-slate-300",
        ) do
          if error.present?
            div id: "form-error-message", class: "text-red-700 text-lg font-semibold" do
              p do
                raw safe("&#9888; #{error}")
              end
            end
          end

          if notice.present?
            div id: "form-notice-message", class: "text-green-700 text-lg font-semibold" do
              p do
                raw safe("&#10004; #{notice}")
              end
            end
          end

          div class: "mx-auto pt-2 pb-4" do
            p class: "text-2xl font-bold text-slate-500" do
              "Sign In"
            end
          end

          form_with(
            url: session_url,
            class: "contents",
            data: { controller: "form", action: "form#submit" }
          ) do |form|
            div id: "email-input-container", class: "flex flex-col", data: { controller: "input", input_target: "container" } do
              form.label(:email_address, "Email", class: "font-semibold text-slate-800 mb-1")
              form.email_field(
                :email_address,
                class: "input-field input-normal",
                required: true,
                autofocus: true,
                placeholder: "name@example.com",
                value: email_address,
                autocomplete: "username",
                data: { input_target: "input", action: "invalid->input#invalid input#changed" }
              )
            end

            div id: "password-input-container", class: "flex flex-col", data: { controller: "input", input_target: "container" } do
              form.label(:password, class: "font-semibold text-slate-800 mb-1")
              form.password_field(
                :password,
                class: "input-field input-normal",
                placeholder: "Password",
                minlength: 12,
                required: true,
                autocomplete: "current-password",
                data: { input_target: "input", action: "invalid->input#invalid input#changed" }
              )
            end

            render Components::Forms::SubmitButton.new(form:, cta_text: "Sign In")
          end
        end
      end

      private

      attr_reader :email_address, :error, :notice
    end
  end
end
