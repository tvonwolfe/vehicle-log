class User
  module Invitable
    extend ActiveSupport::Concern

    included do
      has_one :invitation, dependent: :destroy

      def self.create_from_invitation(invitation, user_params = {})
        raise ArgumentError, "invitation is blank" if invitation.blank?
        raise InvitationAlreadyAccepted, "Invitation already accepted" if invitation.accepted?

        Rails.logger.info(self.class.name) do
          "[#{self.class.name}.#{__method__}]: invitation ID=#{invitation.id}, user_params=#{user_params.to_json}"
        end

        user = User.new(user_params)

        user.transaction do
          user.save
          invitation.update(user: user)
        end

        user
      end
    end

    class InvitationAlreadyAccepted < StandardError; end
  end
end
