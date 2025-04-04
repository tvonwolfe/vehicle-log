class SignUpsController < ApplicationController
  before_action :set_invitation
  before_action :require_invitation, only: :create
  before_action :require_matching_passwords, only: :create

  allow_unauthenticated_access only: %i[show create]

  def show
    render Views::SignUps::Show.new(invitation:)
  end

  def create
    user = User.create_from_invitation(invitation, user_params)

    if user.persisted?
      redirect_to new_session_path(email_address: user.email_address, sign_up_success: true)
    else
      render Views::SignUps::Show.new(invitation:, error: "Couldn't create account. Please try again later."), status: :bad_request
    end
  end

  private

  attr_reader :invitation

  def require_invitation
    if invitation.blank?
      render Views::SignUps::Show.new(invitation:, error: "Invitation not found."), status: :unprocessable_entity
      return
    end

    if invitation.accepted?
      render Views::SignUps::Show.new(invitation:, error: "Invitation already accepted."), status: :unprocessable_entity
    end
  end

  def require_matching_passwords
    password_confirmation = params.dig(:user, :password_confirmation)
    return if user_params[:password] == password_confirmation

    render Views::SignUps::Show.new(invitation:, error: "Passwords must match."), status: :unprocessable_entity
  end

  def set_invitation
    @invitation = Invitation.find_by(code: params[:invite_code])
  end

  def user_params
    params.require(:user).permit(
      :email_address,
      :password,
    )
  end
end
