class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: :render_too_many_requests

  before_action :redirect_active_session, only: :new

  def new
    sign_up_success = params[:sign_up_success]&.downcase&.to_s == "true"
    email_address = params[:email_address]

    render Views::Sessions::SignIn.new(
      email_address:,
      notice: sign_up_success ? "Sign up successful!" : nil
    )
  end

  def create
    if user = User.authenticate_by(auth_params)
      start_new_session_for user
      redirect_to after_authentication_url
    else
      render Views::Sessions::SignIn.new(email_address: params[:email_address], error: "Invalid email or password."), status: :bad_request
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  private

  def redirect_active_session
    return unless current_user.present?

    redirect_to root_path
  end

  def render_too_many_requests
    render Views::Sessions::SignIn.new(email_address: params[:email_address], error: "Try again later."), status: :too_many_requests
  end

  def auth_params
    params.permit(:email_address, :password)
  end
end
