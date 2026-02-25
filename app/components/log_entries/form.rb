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
            render Forms::ErrorMessage.new(error: error.full_message)
          end

            form_with(model: log_entry, url: form_url, class: "flex flex-col",
                      data: { controller: "form", action: "form#submit" }) do |form|
              form.fields_for(:service_record) do |service_record_form|
                render Forms::TextInput.new(form: service_record_form, param: :title, placeholder: "Oil Change", required: true)
                div class: "sm:flex sm:justify-between sm:gap-4" do
                  div class: "flex flex-col w-full" do
                    label(for: "log_entry_service_record_attributes_service_record_type", class: "font-semibold text-slate-800 mb-1") { "Entry Type" }
                    select id: "log_entry_service_record_type", class: "input-field input-select input-normal", name: "log_entry[service_record_attributes][service_type]" do
                      ServiceRecord.service_types.values.each do |value|
                        option(value: value) { value.capitalize }
                      end
                    end
                  end
                  render Forms::TextInput.new(
                    form: service_record_form,
                    param: :cost,
                    required: false,
                    inputmode: :decimal,
                    data: {
                      controller: "autonumeric",
                      autonumeric_currency_value: Money.default_currency.symbol,
                      autonumeric_decimal_places_value: 2
                    }
                  )
                end
                div class: "sm:flex sm:justify-between sm:gap-4" do
                  render Forms::DateInput.new(form:, param: :performed_on, label: "Date Performed", required: true, max: Date.current.to_s)
                  render Forms::TextInput.new(
                    form:,
                    param: :mileage,
                    label: "Recorded Mileage",
                    required: true,
                    placeholder: "87,243",
                    inputmode: :decimal,
                    data: {
                      controller: "autonumeric",
                      autonumeric_max_value: 10_000_000
                    },
                  )
                end
                render Forms::TextAreaInput.new(form: service_record_form, param: :description)

                service_record_form.label :attachments, class: "font-semibold text-slate-800 mb-1"
                service_record_form.file_field :attachments, multiple: true, class: "h-10"
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
