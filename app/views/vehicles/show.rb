module Views
  module Vehicles
    class Show < Base
      attr_reader :vehicle

      def initialize(vehicle)
        @vehicle = vehicle
      end

      def view_template
        h1 { vehicle.vin }
      end
    end
  end
end
