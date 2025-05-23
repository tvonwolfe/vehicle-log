describe LogEntry, type: :model do
  subject(:log_entry) { build(:log_entry) }

  describe "validations" do
    it "is invalid without a performed_on" do
      log_entry.performed_on = nil
      expect(log_entry).not_to be_valid
      expect(log_entry.errors.as_json).to eq({ performed_on: [ "can't be blank" ] })
    end

    it "is invalid if performed_on is in the future" do
      log_entry.performed_on = Date.tomorrow
      expect(log_entry).not_to be_valid
      expect(log_entry.errors.as_json).to eq({ performed_on: [ "can't be in the future" ] })
    end

    it "is invalid without a recorded mileage" do
      log_entry.mileage = nil
      expect(log_entry).not_to be_valid
      expect(log_entry.errors.as_json).to eq({ mileage: [ "can't be blank", "is not a number" ] })
    end

    it "is invalid with a negative recorded mileage" do
      log_entry.mileage = -1
      expect(log_entry).not_to be_valid
      expect(log_entry.errors.as_json).to eq({ mileage: [ "must be greater than or equal to 0" ] })
    end

    context "when there are other log_entries associated with the vehicle" do
      let(:vehicle) do
        vehicle = log_entry.vehicle
        vehicle.save!

        vehicle
      end
      let(:last_recorded_mileage) { 1_000_000 }

      before do
        create(:log_entry, mileage: last_recorded_mileage, vehicle:)
      end

      it "is invalid if mileage is lower than previously recorded" do
        log_entry.mileage = 999_999
        expect(log_entry).not_to be_valid
        expect(log_entry.errors.as_json).to eq({ mileage: [ "can't be lower than last mileage reading of 1000000" ] })
      end
    end

    context "when there is an associated service record" do
      subject(:log_entry) { build(:log_entry, :with_service_record) }

      it "is invalid if the service record is invalid" do
        log_entry.service_record.service_type = nil
        expect(log_entry).not_to be_valid
        expect(log_entry.errors.as_json).to eq({ service_record: [ "is invalid" ], "service_record.service_type": [ "can't be blank", "is not included in the list" ] })
      end
    end
  end
end
