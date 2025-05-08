module Components
  module Vehicles
    class ServiceTimeline < Base
      def initialize(vehicle)
        @vehicle = vehicle
      end

      def view_template
      end

      private

      delegate :log_entries, to: :vehicle, private: true
      attr_reader :vehicle
    end
  end
end
