module Components
  module LogEntries
    class Form < Base
      include Phlex::Rails::Helpers::FormWith

      attr_reader :log_entry


      def initialize(log_entry)
        @log_entry = log_entry
        @service_record = @log_entry.service_record || @log_entry.build_service_record
      end

      def view_template
        div id: "log-entry-form", class: "w-full" do
          log_entry.errors.each do |error|
            render Components::Forms::ErrorMessage.new(error: error.full_message)
          end

            form_with(model: log_entry, url: form_url, class: "flex flex-col",
                      data: { controller: "form", action: "form#submit" }) do |form|
              div class: "sm:flex sm:justify-between sm:gap-4" do
                render Forms::DateInput.new(form:, param: :performed_on, label: "Date Performed", required: true, max: Date.current.to_s)
                render Forms::TextInput.new(form:, param: :mileage, label: "Recorded Mileage", required: true, placeholder: "87,243", type: :number, value: last_mileage_reading.to_i, min: last_mileage_reading.to_i)
              end
              form.fields_for(:service_record) do |service_record_form|
                render Forms::TextInput.new(form: service_record_form, param: :cost_cents, label: "Cost", type: :number, required: true, min: 0)
                render Forms::TextInput.new(form: service_record_form, param: :title, required: true)
              end

              render Forms::SubmitButton.new(form:, cta_text: "Save")
            end
        end
      end

      private

      delegate :vehicle, to: :log_entry, private: true
      delegate :last_mileage_reading, to: :vehicle, private: true

      def form_url
        if log_entry.persisted?
          log_entry_path(log_entry)
        else
          vehicle_log_entries_path(log_entry.vehicle)
        end
      end
    end
  end
end
