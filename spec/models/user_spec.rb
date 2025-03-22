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
end
