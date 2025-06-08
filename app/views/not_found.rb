module Views
  class NotFound < Base
    def view_template
      div class: "w-full h-full flex flex-col justify-around" do
        div class: "mx-auto text-center" do
          p class: "text-3xl font-bold text-slate-700" do
            "Not Found."
          end
          render Components::Link.new(href: root_path, text: "← Go Home")
        end
      end
    end
  end
end
