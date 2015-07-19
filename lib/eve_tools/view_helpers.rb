module EveTools
  module ViewHelpers
    def igb
      @igb ||= IGB.new(request)
    end
  end
end

