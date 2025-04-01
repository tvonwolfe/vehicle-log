class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: { ie: false }
end
