module Views
  module Vehicles
    class Index < Base
      include Phlex::Rails::Helpers::LinkTo

      def initialize(vehicles)
        @vehicles = vehicles
      end

      def view_template
        div class: "mt-4 mb-8 flex justify-between items-center" do
          a href: vehicles_path do
            h1 class: "text-3xl text-slate-500 font-bold" do
              "Vehicles"
            end
          end

          render Components::LinkButton(href: new_vehicle_path, text: "Add Vehicle")
        end

        if vehicles.any?
          render_vehicles
        else
          render_no_vehicles
        end
      end

      private

      def render_no_vehicles
        div class: "h-2/5 flex justify-center align-middle" do
          span class: "m-auto text-xl text-slate-400 font-semibold" do
            p { "No vehicles saved yet." }
            p do
              plain "Add one "
              link_to "here", new_vehicle_path, class: "underline"
              plain "."
            end
          end
        end
      end

      def render_vehicles
        ol id: "vehicles-list", class: "flex flex-col gap-2" do
          vehicles.each do |vehicle|
            render Components::Vehicles::ListItem.new(vehicle)
          end
        end
      end

      attr_reader :vehicles
    end
  end
end
