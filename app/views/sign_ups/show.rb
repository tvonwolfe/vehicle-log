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
        render Components::Header

        div(
          id: "signup-form",
          class: "w-full sm:max-w-lg sm:mx-auto sm:mt-10 \
                  sm:border sm:rounded sm:p-5 md:p-10 sm:shadow-lg \
                  sm:border sm:border-slate-300",
        ) do
          if error.present?
            render Forms::ErrorMessage.new(error:)
          end

          div class: "mx-auto pt-2 pb-4" do
            p class: "text-2xl font-bold text-slate-500" do
              "Sign Up"
            end
          end

          form_with(
            url: sign_up_path,
            class: "flex flex-col",
            data: { controller: "form", action: "form#submit" }
          ) do |form|
            form.hidden_field(:invite_code, value: invitation&.code)

            div id: "email-input-container", class: "flex flex-col", data: { controller: "input", input_target: "container" } do
              form.label(:email_address, "Email", class: "font-semibold text-slate-800 mb-1")
              form.email_field(
                :email_address,
                name: "user[email_address]",
                class: "input-field input-normal",
                placeholder: "name@example.com",
                required: true,
                autofocus: true,
                data: { input_target: "input", action: "invalid->input#invalid input#changed" }
              )
            end

            div data: { controller: "password-confirmation" } do
              div id: "password-input-container", class: "flex flex-col", data: { controller: "input", input_target: "container" } do
                form.label(:password, class: "font-semibold text-slate-800 mb-1")
                form.password_field(
                  :password,
                  name: "user[password]",
                  class: "input-field input-normal",
                  placeholder: "Password (min. 12 characters)",
                  minlength: 12,
                  required: true,
                  data: { input_target: "input", password_confirmation_target: "password", action: "invalid->input#invalid input#changed password-confirmation#changed" }
                )
              end

              div id: "password-confirmation-input-container", class: "flex flex-col", data: { controller: "input", input_target: "container" } do
                form.label(:password_confirmation, "Confirm Password", class: "font-semibold text-slate-800 mb-1")
                form.password_field(
                  :password_confirmation,
                  name: "user[password_confirmation]",
                  class: "input-field input-normal",
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
