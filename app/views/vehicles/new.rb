# frozen_string_literal: true

module Views
  module Vehicles
    class New < Base
      attr_reader :vehicle

      def initialize(vehicle)
        @vehicle = vehicle
      end

      def view_template
        div class: "sm:max-w-lg sm:mx-auto mt-4" do
          render Components::Link.new(href: vehicles_path, text: "← All Vehicles")
          div class: "flex gap-2 flex-col justify-between mt-2 sm:mt-6 pt-4 sm:pt-0" do
            div class: "pb-4" do
              p class: "text-2xl font-bold text-slate-600" do
                "Add a Vehicle"
              end
            end
          end
          render Components::Vehicles::Form.new(vehicle)
        end
      end
    end
  end
end
