describe Views::Signups::Show, type: :component do
  let(:invitation) { build(:invitation) }
  let(:view) { described_class.new(invitation:) }

  it "renders with the given invitation code" do
    output = render(view)

    expect(output).to match(/<div id="signup-form"/)
    expect(output).to match(/<input name="invite_code" value="#{invitation.code}".*type="hidden"/)
    expect(output).to match(/Create Account/)
  end

  it "does not render errors" do
    output = render(view)

    expect(output).not_to match(/form-error-message/)
  end

  context "when there is an error message provided" do
    let(:view) { described_class.new(invitation:, error: "Bad invite") }

    it "renders the error message" do
      output = render(view)

      expect(output).to match(/<div id="form-error-message".*<p>.*&#9888; Bad invite<\/p>/)
    end
  end
end
