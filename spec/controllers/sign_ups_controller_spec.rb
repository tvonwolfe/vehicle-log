describe SignUpsController, type: :controller do
  let(:invitation) { create(:invitation) }

  describe "GET /sign_up" do
    let(:params) { {  invite_code: invitation.code  } }

    before do
      allow(Views::SignUps::Show).to receive(:new).with(invitation:).and_call_original
    end

    it "renders the correct view" do
      get :show, params: params

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(Views::SignUps::Show).to have_received(:new).with(invitation:)
    end

    context "when the invitation is not found" do
      let(:params) { { invit_code: SecureRandom.alphanumeric } }

      before do
        allow(Views::SignUps::Show).to receive(:new).with(invitation: nil).and_call_original
      end

      it "renders the view" do
        get :show, params: params

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(Views::SignUps::Show).to have_received(:new).with(invitation: nil)
      end
    end
  end

  describe "POST /sign_up" do
    let(:user_params) { attributes_for(:user) }
    let(:params) do
      {
        user: user_params.merge(password_confirmation: user_params[:password]),
        invite_code: invitation.code
      }
    end

    it "redirects correctly" do
      post :create, params: params

      expect(response).to redirect_to new_session_path(email_address: user_params[:email_address], sign_up_success: true)
    end

    it "creates a user with the given parameters" do
      expect do
        post :create, params: params
      end.to change(User, :count).by(1)

      expect(response).to have_http_status(:found)
      expect(User.authenticate_by(user_params)).to eq(User.last)
    end

    it "consumes the invitation" do
      expect do
        post :create, params: params
      end.to change { invitation.reload.user }
        .and change(invitation.reload, :accepted?).from(false).to(true)
    end

    context "when the invitation has already been accepted by someone else" do
      let!(:invitation) { create(:invitation, :with_user) }

      before do
        allow(Views::SignUps::Show).to receive(:new).and_call_original
      end

      it "responds with an error status" do
        post :create, params: params

        expect(response).not_to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders the signup view with the correct error message" do
        post :create, params: params

        expect(Views::SignUps::Show).to have_received(:new).with(
          invitation: having_attributes(id: invitation.id),
          error: "Invitation already accepted."
        )
      end

      it "does not create a new user" do
        expect do
          post :create, params: params
        end.not_to change(User, :count)
      end

      it "does not consume the invitation again" do
        expect do
          post :create, params: params
        end.not_to change { invitation.reload.user_id }
      end
    end

    context "when the invitation cannot be found with the provided code" do
      let(:params) do
        {
          user: user_params.merge(password_confirmation: user_params[:password]),
          invite_code: SecureRandom.alphanumeric
        }
      end

      before do
        allow(Views::SignUps::Show).to receive(:new).and_call_original
      end

      it "responds with an error status" do
        post :create, params: params

        expect(response).not_to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders the signup view with the correct error message" do
        post :create, params: params

        expect(Views::SignUps::Show).to have_received(:new).with(
          invitation: nil,
          error: "Invitation not found."
        )
      end

      it "does not create a new user" do
        expect do
          post :create, params: params
        end.not_to change(User, :count)
      end
    end

    context "when the password params do not match" do
      let(:params) do
        {
          user: user_params.merge(password_confirmation: SecureRandom.alphanumeric),
          invite_code: invitation.code
        }
      end

      before do
        allow(Views::SignUps::Show).to receive(:new).and_call_original
      end

      it "responds with an error status" do
        post :create, params: params

        expect(response).not_to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders the signup view with the correct error message" do
        post :create, params: params

        expect(Views::SignUps::Show).to have_received(:new).with(invitation: having_attributes(id: invitation.id), error: "Passwords must match.")
      end

      it "does not create a new user" do
        expect do
          post :create, params: params
        end.not_to change(User, :count)
      end
    end
  end
end
