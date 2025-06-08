module Components
  module Vehicles
    class ServiceTimeline < Base
      include Phlex::Rails::Helpers::LinkTo
      include Phlex::Rails::Helpers::NumberWithDelimiter

      def initialize(vehicle)
        @vehicle = vehicle
      end

      def view_template
        div id: "vehicle-#{vehicle.id}-service-timeline" do
          div class: "flex justify-between mb-2" do
            h3 class: "text-2xl font-bold self-center" do
              "Service History"
            end
            render Components::LinkButton(href: new_vehicle_log_entry_path(vehicle), text: "Add Entry")
          end

          div id: "timeline-list", class: "flex flex-col gap-1 max-w-full" do
            if log_entries.any?
              log_entries.each do |log_entry|
                timeline_entry(log_entry)
              end
            else
              div class: "flex justify-center align-middle mt-10" do
                span class: "m-auto text-xl text-slate-400 font-semibold" do
                  p { "No service history." }
                  p do
                    plain "Add a new entry "
                    link_to "here", new_vehicle_log_entry_path(vehicle), class: "underline"
                    plain "."
                  end
                end
              end
            end
          end
        end
      end

      private

      def timeline_entry(log_entry)
        mileage_update = log_entry.service_record.blank?

        div id: "timeline-list-entry-#{log_entry.id}", class: "flex my-2 gap-2" do
          time datetime: log_entry.performed_on.to_s, class: "text-slate-500 font-mono self-center text-nowrap" do
            log_entry.performed_on.to_s
          end
          div class: "border-l"
          p class: "self-center sm:text-xl text-slate-800 #{mileage_update ? 'italic' : 'font-semibold'}".strip do
            if mileage_update
              "Mileage Updated to #{number_with_delimiter(log_entry.mileage)}"
            else
              a href: log_entry_path(log_entry) do
                log_entry.service_record.title
              end
            end
          end
        end
      end

      delegate :log_entries, to: :vehicle, private: true
      attr_reader :vehicle
    end
  end
end
