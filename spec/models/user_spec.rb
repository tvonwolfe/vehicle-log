describe User do
  let(:user) { build(:user) }

  describe "validations" do
    it "is invalid without an email address" do
      user.email_address = nil
      expect(user).not_to be_valid

      expect(user.errors.as_json).to eq({ email_address: [ "can't be blank", "is invalid" ] })
    end

    it "is invalid without a unique email address" do
      existing_user = create(:user)
      user.email_address = existing_user.email_address

      expect(user).not_to be_valid
      expect(user.errors.as_json).to eq({ email_address: [ "has already been taken" ] })
    end

    it "is invalid without a valid email address" do
      user.email_address = "just_a_domain.com"

      expect(user).not_to be_valid
      expect(user.errors.as_json).to eq({ email_address: [ "is invalid" ] })
    end
  end

  describe "Invitable" do
    describe ".create_from_invitation" do
      let(:invitation) { create(:invitation) }
      let(:user_params) { attributes_for(:user) }

      it "consumes the invitation and creates a user record" do
        expect do
          described_class.create_from_invitation(invitation, user_params)
        end.to change(described_class, :count).by(1)
          .and change(invitation.reload, :user_id)
      end

      context "when the invitation has already been used" do
        before do
          create(:user)
          invitation.update!(user:)
        end

        it "raises an error" do
          expect do
            described_class.create_from_invitation(invitation, user_params)
          end.to raise_error(described_class::Invitable::InvitationAlreadyAccepted, /already accepted/)
        end
      end
    end
  end
end
