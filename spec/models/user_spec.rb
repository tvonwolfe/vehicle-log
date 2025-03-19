describe User do
  let(:user) { build(:user) }

  describe "validations" do
    it "is invalid without an email address" do
      user.email_address = nil
      expect(user).not_to be_valid

      expect(user.errors.as_json).to eq({ email_address: [ "can't be blank" ] })
    end

    it "is invalid without a unique email address" do
      existing_user = create(:user)
      user.email_address = existing_user.email_address

      expect(user).not_to be_valid
      expect(user.errors.as_json).to eq({ email_address: [ "has already been taken" ] })
    end
  end
end
