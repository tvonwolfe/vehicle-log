describe Invitation do
  subject(:invitation) { build(:invitation) }

  describe "validations" do
    it "is invalid without a code" do
      invitation.code = nil

      expect(invitation).not_to be_valid
      expect(invitation.errors.as_json).to eq({ code: [ "can't be blank" ] })
    end

    it "is invalid without a unique code" do
      create(:invitation, code: invitation.code)

      expect(invitation).not_to be_valid
      expect(invitation.errors.as_json).to eq({ code: [ "has already been taken" ] })
    end

    it "is valid without a user" do
      expect(invitation).to be_valid
    end

    it "is valid with a user" do
      invitation.user = build(:user)
      expect(invitation).to be_valid
    end
  end

  describe "#accepted?" do
    context "when not associated with a user" do
      it "returns false" do
        expect(invitation.accepted?).to be false
      end
    end

    context "when associated with a user" do
      let(:invitation) { build(:invitation, :with_user) }

      it "returns true" do
        expect(invitation.accepted?).to be true
      end
    end
  end
end
