describe Components::Forms::ErrorMessage, type: :component do
  let(:error) { "There was an error of some kind" }

  let(:component) { described_class.new(error:) }
  let(:output) { render component }

  it "renders the expected html tag" do
    expect(output).to match(/\A<div data-testid="error-message"/)
  end

  it "renders a warning symbol" do
    expect(output).to match(/&#9888;/)
  end

  it "renders the error message" do
    expect(output).to match(/<p>#{error}<\/p>/)
  end
end
