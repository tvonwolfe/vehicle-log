module Views
  module Vehicles
    class Index < Base
      def initialize(vehicles)
        @vehicles = vehicles
      end

      def view_template
        h1 do
          vehicles.pluck(:id).join(", ")
        end
      end

      private

      attr_reader :vehicles
    end
  end
end
