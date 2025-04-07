describe Components::LinkButton, type: :component do
  let(:text) { "Some Text" }
  let(:href) { "https://example.com" }

  let(:component) { described_class.new(text:, href:) }
  let(:output) { render(component) }

  it "renders the expected HTML tag" do
    expect(output).to match(/\A<a /)
  end

  it "renders the expected URL link" do
    expect(output).to match(/href="#{href}"/)
  end

  it "renders the provided text" do
    expect(output).to match(/#{text}/)
  end
end
