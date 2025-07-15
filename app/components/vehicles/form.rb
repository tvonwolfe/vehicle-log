# frozen_string_literal: true

module Components
  module Vehicles
    class Form < Base
      include Phlex::Rails::Helpers::FormWith

      PlaceholderOption = Data.define(:make, :model)

      PLACEHOLDERS = [
        { make: "Acura",         model: "NSX"              },
        { make: "Alfa Romeo",    model: "Giulia Sprint GT" },
        { make: "Alpina",        model: "B7"               },
        { make: "BMW",           model: "525iT"            },
        { make: "Ford",          model: "Fiesta ST"        },
        { make: "Honda",         model: "Civic Si"         },
        { make: "Mazda",         model: "Miata"            },
        { make: "Mercedes-Benz", model: "300TE"            },
        { make: "Nissan",        model: "Skyline"          },
        { make: "Peugeot",       model: "205 GTi"          },
        { make: "Subaru",        model: "WRX STI"          },
        { make: "Toyota",        model: "AE86"             },
        { make: "Volkswagen",    model: "Golf GTI"         }
      ].map { |args| PlaceholderOption.new(**args) }.freeze

      attr_reader :vehicle

      def initialize(vehicle)
        @vehicle = vehicle
      end

      def view_template
        placeholder = PLACEHOLDERS.sample
        div id: "vehicle-form", class: "w-full" do
          Rails.logger.error(self.class.name) { vehicle.errors.full_messages }

          vehicle.errors.each do |error|
            render Components::Forms::ErrorMessage.new(error: error.full_message)
          end

          form_with(model: vehicle, class: "flex flex-col",
                    data: { controller: "form", action: "form#submit" }) do |form|
            render Components::Forms::TextInput.new(form:, param: :manufacturer, label: "Make", placeholder: placeholder.make, required: true)
            render Components::Forms::TextInput.new(form:, param: :model, placeholder: placeholder.model, required: true)
            render Components::Forms::TextInput.new(form:, param: :vin, label: "VIN", placeholder: "VIN", required: true, autocapitalize: "characters")

            div class: "flex flex-col md:flex-row md:justify-between md:gap-2" do
              div class: "flex flex-col w-full" do
                form.label(:model_year, class: "font-semibold text-slate-800 mb-1")
                select id: "vehicle_model_year", class: "input-field input-select input-normal", name: "#{vehicle.class.name.downcase}[model_year]" do
                  Vehicle.valid_model_years.reverse.each_with_index do |year, index|
                    option(value: year) { year }
                  end
                end
              end
              render Components::Forms::TextInput.new(form:, param: :license_plate_number, label: "License Plate Number (optional)", placeholder: "License Plate #", autocapitalize: "characters")
            end
            render Components::Forms::SubmitButton.new(form:, cta_text: "Save")
          end
        end
      end
    end
  end
end
