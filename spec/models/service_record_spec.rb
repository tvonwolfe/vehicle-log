RSpec.describe ServiceRecord do
  subject(:service_record) { build(:service_record) }

  describe "validations" do
    it "is invalid without a service_type" do
      service_record.service_type = nil
      expect(service_record).not_to be_valid
    end
  end
end
