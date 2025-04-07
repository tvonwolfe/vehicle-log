module Components
  module Vehicles
    class ListItem < Base
      def initialize(vehicle)
        @vehicle = vehicle
      end

      def view_template
        li id: "vehicle-li-#{vehicle.id}",
           class: "vehicle-list-item" do
          a href: vehicle_path(vehicle) do
            div do
              p class: "text-xl font-semibold text-slate-600" do
                vehicle.humanized_name
              end
              p class: "text-slate-400" do
                vehicle.vin
              end
            end
          end
        end
      end

      private

      attr_reader :vehicle
    end
  end
end
