class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: { ie: false }

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from CanCan::AccessDenied, with: :render_not_found

  def render_not_found
    render Views::NotFound
  end
end
