describe Components::Vehicles::ListItem, type: :component do
  let(:vehicle) { create(:vehicle) }
  let(:component) { described_class.new(vehicle) }

  it "renders the expected HTML" do
    output = render(component)

    expect(output).to match(/\A<li id="vehicle-li-#{vehicle.id}"/)
    expect(output).to match(/<a href="\/vehicles\/#{vehicle.vin}"/)
    expect(output).to match(/<p.*>#{vehicle.humanized_name}<\/p>/)
    expect(output).to match(/<p.*>#{vehicle.vin}<\/p>/)
  end
end
