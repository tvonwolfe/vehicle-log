module Views
  module LogEntries
    class Show < Base
      include Phlex::Rails::Helpers::DOMID

      attr_reader :log_entry

      def initialize(log_entry)
        @log_entry = log_entry
      end

      def view_template
        div id: dom_id(log_entry), class: "my-4" do
          render Components::Link.new(href: vehicle_path(vehicle), text: "← #{vehicle.humanized_name}")
        end
      end

      private

      delegate :vehicle, to: :log_entry, private: true
    end
  end
end
