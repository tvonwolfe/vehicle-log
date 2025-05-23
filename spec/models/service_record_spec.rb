describe ServiceRecord, type: :model do
  subject(:service_record) { build(:service_record) }

  describe "validations" do
    it "is invalid without a title" do
      service_record.title = nil

      expect(service_record).not_to be_valid
      expect(service_record.errors.as_json).to eq({ title: [ "can't be blank" ] })
    end

    it "is invalid if title is too long" do
      service_record.title = Faker::Alphanumeric.alphanumeric(number: 129)

      expect(service_record).not_to be_valid
      expect(service_record.errors.as_json).to eq({ title: [ "is too long (maximum is 128 characters)" ] })
    end

    it "is invalid if description is too long" do
      service_record.description = Faker::Alphanumeric.alphanumeric(number: 10_001)

      expect(service_record).not_to be_valid
      expect(service_record.errors.as_json).to eq({ description: [ "is too long (maximum is 10000 characters)" ] })
    end

    it "is invalid without a service_type" do
      service_record.service_type = nil

      expect(service_record).not_to be_valid
      expect(service_record.errors.as_json).to eq({ service_type: [ "can't be blank", "is not included in the list" ] })
    end

    it "prevents using an invalid service_type" do
      expect do
        service_record.service_type = :turbo
      end.to raise_error(ArgumentError)
    end

    it "is invalid if cost is less than $0" do
      service_record.cost = -1

      expect(service_record).not_to be_valid
      expect(service_record.errors.as_json).to eq({ cost: [ "can't be less than $0.00" ] })
    end
  end

  describe "#cost" do
    subject(:service_record) { build(:service_record, cost: cost_dollars) }

    let(:cost_dollars) { 25 }

    it "returns a Money instance" do
      expect(service_record.cost).to be_a Money
    end

    it "formats the monetary amount correctly" do
      expect(service_record.cost.format).to eq("$25.00")
    end
  end
end
