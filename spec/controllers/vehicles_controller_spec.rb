describe VehiclesController, type: :controller do
  let(:user) { create(:user) }
  let(:session) { create(:session, user:) }

  before do
    allow(Current).to receive(:session).and_return(session)
  end

  describe "GET /vehicles" do
    let!(:user_vehicles) { create_list(:vehicle, 3, user:) }

    before do
      allow(Views::Vehicles::Index).to receive(:new).and_call_original
      create(:vehicle) # create another vehicle, ensure it doesn't get retrieved/rendered
    end

    it "retrieves and renders all vehicles for a particular user" do
      get :index

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(Views::Vehicles::Index).to have_received(:new).with(user_vehicles)
    end
  end

  describe "GET /vehicle/:vin" do
    let(:vehicle) { create(:vehicle, user:) }
    let(:params) { { vin: vehicle.vin } }

    before do
      allow(Views::Vehicles::Show).to receive(:new).and_call_original
    end

    it "retrieves and renders the vehicle with the specified VIN" do
      get :show, params: params

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(Views::Vehicles::Show).to have_received(:new).with(vehicle)
    end

    context "when no vehicle exists" do
      let(:params) { { vin: "no-such-vin" } }

      it "returns a 404 error", pending: "https://github.com/tvonwolfe/vehicle-log/issues/59"
    end

    context "when a vehicle exists with the given VIN but doesn't belong to the User" do
      let(:params) { { vin: create(:vehicle).vin } }

      it "returns a 404 error", pending: "https://github.com/tvonwolfe/vehicle-log/issues/59"
    end
  end

  describe "GET /vehicles/new" do
    before do
      allow(Views::Vehicles::New).to receive(:new).and_call_original
    end

    it "renders the correct view" do
      get :new

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(Views::Vehicles::New).to have_received(:new).with(instance_of(Vehicle))
    end
  end

  describe "POST /vehicles" do
    let(:params) { { vehicle:  attributes_for(:vehicle)  } }

    it "creates a vehicle" do
      expect do
        post :create, params: params
      end.to change(user.vehicles, :count).by 1
    end

    it "redirects to the newly-created vehicle" do
      post :create, params: params

      expect(response).to have_http_status(:found)
    end

    context "when params are invalid" do
      before do
        allow(Views::Vehicles::New).to receive(:new).and_call_original
      end

      shared_examples "an unprocessable request" do
        it "returns an error response" do
          post :create, params: params

          expect(response).not_to be_successful
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "does not create a new Vehicle" do
          expect do
            post :create, params: params
          end.not_to change(Vehicle, :count)
        end
      end

      context "when the user already has a vehicle with the given VIN" do
        let!(:existing_vehicle) { create(:vehicle, user:) }
        let(:params) { { vehicle: attributes_for(:vehicle, vin: existing_vehicle) } }

        it_behaves_like "an unprocessable request"
      end

      context "when required params are blank" do
        let(:params) { { vehicle: attributes_for(:vehicle).except(:vin) } }

        it_behaves_like "an unprocessable request"
      end

      context "when model_year is not valid" do
        let(:params) { { vehicle: attributes_for(:vehicle, model_year: 1924) } }

        it_behaves_like "an unprocessable request"
      end
    end
  end
end
