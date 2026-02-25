module Components
  class Message < Base
    attr_reader :message, :type

    def initialize(message, type)
      @message = message
      @type = type.to_sym
    end

    def view_template
      div class: "w-full flex justify-between text-#{color}-600 bg-#{color}-50 py-2 px-4 rounded-sm mb-4",
          data: { controller: "message" } do
        p { message }
        button(class: "float-right hover:cursor-pointer", data: { action: "message#delete" }) { raw safe("&#0215;") }
      end
    end

    private

    def color
      case type
      when :notice
        :green
      else
        :sky
      end
    end
  end
end
