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
          h3 class: "text-2xl font-bold mb-2" do
            "Service History"
          end

          div id: "timeline-list", class: "flex flex-col gap-1 max-w-full" do
            log_entries.each do |log_entry|
              timeline_entry(log_entry)
            end
          end
        end
      end

      private

      def timeline_entry(log_entry)
        mileage_update = log_entry.service_record.blank?

        title = if mileage_update
          "Mileage Updated to #{number_with_delimiter(log_entry.mileage)}"
        else
          log_entry.service_record.title
        end

        div id: "timeline-list-entry-#{log_entry.id}", class: "flex my-2 gap-2" do
          time datetime: log_entry.performed_on.to_s, class: "text-slate-500 font-mono self-center text-nowrap" do
            log_entry.performed_on.to_s
          end
          div class: "border-l"
          p class: "self-center sm:text-xl text-slate-800 #{mileage_update ? 'italic' : 'font-semibold'}".strip do
            title
          end
        end
      end

      delegate :log_entries, to: :vehicle, private: true
      attr_reader :vehicle
    end
  end
end
