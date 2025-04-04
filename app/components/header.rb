module Components
  class Header < Base
    include Phlex::Rails::Helpers::LinkTo

    def view_template
      header class: "container mx-auto pt-4 flex sm:justify-center" do
        link_to "VehicleLog", root_path, class: "text-slate-700 font-bold text-4xl"
      end
    end
  end
end
