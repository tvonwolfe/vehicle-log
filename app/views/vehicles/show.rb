module Views
  module Vehicles
    class Show < Base
      include Phlex::Rails::Helpers::DOMID

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
              p class: "text-slate-400" do
                vehicle.vin
              end
            end
          end

          render Components::Vehicles::ServiceTimeline.new(vehicle)
        end
      end
    end
  end
end
