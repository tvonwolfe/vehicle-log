# frozen_string_literal: true

module Views
  module SignUps
    class Show < Base
      include Phlex::Rails::Helpers::FormWith

      def initialize(invitation:, error: nil)
        @invitation = invitation
        @error = error
      end

      def view_template
        div(
          id: "signup-form",
          class: "w-full sm:w-1/3 md:w-2/3 lg:w-1/3 sm:mx-auto sm:mt-10 \
                  sm:border sm:rounded sm:p-10 sm:shadow-lg sm:border sm:border-slate-300",
        ) do
          if error.present?
            div id: "form-error-message", class: "text-red-700 text-lg font-semibold" do
              p do
                raw safe("&#9888; #{error}")
              end
            end
          end

          div class: "mx-auto pt-2 pb-4" do
            p class: "text-2xl font-bold text-slate-500" do
              "Sign Up"
            end
          end

          form_with(
            model: User.new,
            url: sign_up_path,
            method: :post,
            class: "flex flex-col",
            data: { controller: "form", action: "form#submit" }
          ) do |form|
            form.hidden_field(:invite_code, name: :invite_code, value: invitation&.code)

            div id: "email-input-container", class: "flex flex-col", data: { controller: "input", input_target: "container" } do
              form.label(:email_address, class: "font-semibold text-slate-800 mb-1")
              form.email_field(
                :email_address,
                class: "input-field input-outline-normal",
                placeholder: "name@example.com",
                required: true,
                data: { input_target: "input", action: "invalid->input#invalid input#changed" }
              )
            end

            div class: "mt-4"

            div data: { controller: "password-confirmation" } do
              div id: "password-input-container", class: "flex flex-col", data: { controller: "input", input_target: "container" } do
                form.label(:password, class: "font-semibold text-slate-800 mb-1")
                form.password_field(
                  :password,
                  class: "input-field input-outline-normal",
                  placeholder: "Password",
                  minlength: 12,
                  required: true,
                  data: { input_target: "input", password_confirmation_target: "password", action: "invalid->input#invalid input#changed password-confirmation#changed" }
                )
              end

              div class: "mt-4"

              div id: "password-confirmation-input-container", class: "flex flex-col", data: { controller: "input", input_target: "container" } do
                form.label(:confirm_password, class: "font-semibold text-slate-800 mb-1")
                form.password_field(
                  :confirm_password,
                  class: "input-field input-outline-normal",
                  placeholder: "Password",
                  minlength: 12,
                  required: true,
                  data: { input_target: "input", password_confirmation_target: "passwordConfirmation", action: "invalid->input#invalid input#changed password-confirmation#changed" }
                )
              end
            end

            render Components::Forms::SubmitButton.new(form:, cta_text: "Create Account")
          end
        end
      end

      private

      attr_reader :invitation, :error
    end
  end
end
