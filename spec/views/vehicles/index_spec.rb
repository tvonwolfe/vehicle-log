describe Views::Vehicles::Index, type: :component do
  let(:vehicles) { create_list(:vehicle, 2) }
  let(:view) { described_class.new(vehicles) }

  before do
    allow(Components::LinkButton).to receive(:new).and_call_original
    allow(Components::Vehicles::ListItem).to receive(:new).and_call_original
  end

  it "renders the expected view" do
    output = render(view)

    expect(output).to match(/Vehicles/)
    expect(output).to match(/Add Vehicle/)
    expect(output).to match(/<ol id="vehicles-list"/)
  end

  it "renders all vehicles" do
    render(view)

    expect(Components::Vehicles::ListItem).to have_received(:new).twice
  end

  context "when there are no vehicles" do
    let(:vehicles) { [] }

    it "renders a prompt with a link to add one" do
      output = render(view)

      expect(output).to match(/No vehicles saved yet./)
      expect(output).to match(/Add one <a.*href="\/vehicles\/new".*>here<\/a>./)
      expect(Components::Vehicles::ListItem).not_to have_received(:new)
    end
  end
end
