module Views
  module Vehicles
    class Show < Base
      include Phlex::Rails::Helpers::DOMID
      include Phlex::Rails::Helpers::NumberWithDelimiter
      include Phlex::Rails::Helpers::ImageTag

      attr_reader :vehicle

      def initialize(vehicle)
        @vehicle = vehicle
      end

      def view_template
        div id: dom_id(vehicle) do
          div class: "flex gap-2 flex-col sm:flex-row justify-between my-4" do
            render Components::Link.new(href: vehicles_path, text: "← All Vehicles")
            span class: "h-full flex flex-col sm:text-right" do
              h2 class: "text-slate-700 font-bold text-3xl" do
                vehicle.humanized_name
              end
              p(class: "text-slate-400") do
                plain "VIN: "
                strong  { vehicle.vin }
              end
              if vehicle.license_plate_number.present?
                p(class: "text-slate-400") do
                  plain "Plate: "
                  strong { vehicle.license_plate_number }
                end
              end
            end
          end

          if vehicle.log_entries.any?
            div class: "border rounded border-slate-300 flex gap-2 flex-wrap justify-between p-4 text-xl mb-8" do
              div class: "self-center flex flex-row gap-2" do
                image_tag("odometer-icon.jpg", alt: "odometer", class: "max-h-8 max-w-6 self-center")
                p class: "self-center" do
                  strong { "Last Mileage: " }
                  plain last_mileage_reading
                end
              end

              div class: "self-center flex flex-row gap-2" do
                image_tag("calendar-icon.png", alt: "calendar", class: "max-h-6 max-w-6 self-center")
                p class: "self-center" do
                  strong { "Last Entry: " }
                  plain last_entry_date
                end
              end
            end
          end

          render Components::Vehicles::ServiceTimeline.new(vehicle)
        end
      end

      private

      def last_mileage_reading = number_with_delimiter(vehicle.last_mileage_reading)

      def last_entry_date = vehicle.log_entries.first.created_at.to_date.to_fs
    end
  end
end
