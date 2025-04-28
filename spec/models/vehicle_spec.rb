describe Vehicle do
  let(:vehicle) { build(:vehicle) }

  describe "validations" do
    it "is invalid without a model_year" do
      vehicle.model_year = nil

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ model_year: [ "can't be blank", "is not a number" ] })
    end

    it "is invalid if model_year is too far in the past" do
      vehicle.model_year = 1924

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ model_year: [ "must be greater than or equal to 1925" ] })
    end

    it "is invalid if model_year is too far in the future" do
      vehicle.model_year = Date.current.year + 2

      expect(vehicle).not_to be_valid
      expect(vehicle.errors.as_json).to eq({ model_year: [ "must be less than or equal to #{Date.current.year + 1}" ] })
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
    let(:vehicle) { build(:vehicle, manufacturer: "Mazda", model: "Miata", model_year: 1991) }

    it "returns the expected string" do
      expect(vehicle.humanized_name).to eq("1991 Mazda Miata")
    end
  end

  describe "#last_mileage_reading" do
    let(:vehicle) { create(:vehicle) }

    context "when there are no associated log entries" do
      it "returns nil" do
        expect(vehicle.last_mileage_reading).to be_nil
      end
    end

    context "when there is one associated log entry" do
      let!(:log_entry) { create(:log_entry, vehicle:) }

      it "returns the mileage of the log entry" do
        expect(vehicle.last_mileage_reading).to eq log_entry.mileage
      end
    end

    context "when there are multiple associated log entries" do
      let!(:log_entries) do
        [ 3, 2, 1 ].map do |i|
          mileage = 10_000 - (i * 10)
          performed_on = Date.current - i.days
          create(:log_entry, vehicle:, mileage:, performed_on:)
        end
      end

      it "returns the mileage of the newest log entry" do
        expect(vehicle.last_mileage_reading).to eq log_entries.last.mileage
      end
    end
  end
end
