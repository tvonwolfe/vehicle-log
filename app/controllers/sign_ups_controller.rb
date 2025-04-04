class SignUpsController < ApplicationController
  before_action :set_invitation
  before_action :require_invitation, only: :create

  skip_before_action :require_authentication

  def show
    render Views::SignUps::Show.new(invitation:)
  end

  def create
    # TODO: enqueue a background job to fire email? or just fire email
    # directly from here?
    user = User.create_from_invitation(invitation, user_params)

    if user.persisted?
      render Views::SignUps::Success.new(user:), status: :created
    else
      # TODO: pass in error message to this component
      render Views::SignUps::Show.new(invitation:, error: "Couldn't create account. Please try again later.")
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

  def set_invitation
    @invitation = Invitation.find_by(code: params[:invite_code])
  end

  def user_params
    params.require(:user).permit(
      :email_address,
      :password
    )
  end
end
