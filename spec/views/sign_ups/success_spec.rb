describe Views::SignUps::Success, type: :component do
  let(:user) { build(:user) }
  let(:view) { described_class.new(user:) }
  let(:output) { render(view) }

  it "renders with the given user's email address" do
    expect(output).to match(/#{user.email_address}/)
    expect(output).to match(/<h1.*Success<\/h1>/)
  end
end
