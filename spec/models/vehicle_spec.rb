describe Vehicle do
  let(:vehicle) { build(:vehicle) }

  describe "validations" do
    it "is invalid without a year" do
      vehicle.year = nil

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ year: [ "can't be blank", "is not a number" ] })
    end

    it "is invalid if year is too far in the past" do
      vehicle.year = 1924

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ year: [ "must be greater than or equal to 1925" ] })
    end

    it "is invalid if year is too far in the future" do
      vehicle.year = Date.current.year + 2

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ year: [ "must be less than or equal to #{Date.current.year + 1}" ] })
    end

    it "is invalid without a manufacturer" do
      vehicle.manufacturer = nil

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ manufacturer: [ "can't be blank" ] })
    end

    it "is invalid without a model" do
      vehicle.model = nil

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ model: [ "can't be blank" ] })
    end

    it "is invalid without a vin" do
      vehicle.vin = nil

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ vin: [ "can't be blank" ] })
    end

    context "when the vin is not unique to the user" do
      let(:other_vehicle) { build(:vehicle, vin: vehicle.vin, user: vehicle.user) }

      before do
        other_vehicle.save!
      end

      it "is invalid" do
        expect(vehicle).not_to be_valid
        expect(vehicle.errors.as_json).to eq({ vin: [ "has already been taken" ] })
      end
    end
  end

  describe "#humanized_name" do
    let(:vehicle) { build(:vehicle, manufacturer: "Mazda", model: "Miata", year: 1991) }

    it "returns the expected string" do
      expect(vehicle.humanized_name).to eq("1991 Mazda Miata")
    end
  end
end
