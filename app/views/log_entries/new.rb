module Views
  module LogEntries
    class New < Base
      attr_reader :log_entry

      def initialize(log_entry)
        @log_entry = log_entry
      end

      def view_template
        div class: "sm:max-w-lg sm:mx-auto mt-4" do
          render Components::Link.new(href: vehicle_path(vehicle), text: "← Back to Vehicle")
          div class: "flex gap-2 flex-col justify-between mt-2 sm:mt-6 pt-4 sm:pt-0" do
            div class: "pb-4" do
              p class: "text-2xl font-bold text-slate-600" do
                "Add a Log Entry"
              end
            end
          end
          render Components::LogEntries::Form.new(log_entry)
        end
      end

      private

      delegate :vehicle, to: :log_entry, private: true
    end
  end
end
