require 'eve_tools/view_helpers'
module EveTools
  class Railtie < Rails::Railtie
    initializer 'eve_tools.view_helpers' do
      ActionView::Base.send :include, ViewHelpers
      ActionController::Base.send :include, ViewHelpers
    end
  end
end
