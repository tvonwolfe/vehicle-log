# frozen_string_literal: true

module Views
  module Vehicles
    class Edit < Base
      attr_reader :vehicle

      def initialize(vehicle)
        @vehicle = vehicle
      end

      def view_template
        div class: "sm:max-w-lg sm:mx-auto mt-4 sm:mt-6" do
          render Components::Link.new(href: vehicle_path(vehicle), text: "← Back to Vehicle")
          div class: "flex gap-2 flex-col justify-between mt-2 sm:mt-6 pt-4 sm:pt-0" do
            div class: "pb-4" do
              p class: "text-2xl font-bold text-slate-600" do
                "Edit Vehicle"
              end
            end
          end
          render Components::Vehicles::Form.new(vehicle)
        end
      end
    end
  end
end
