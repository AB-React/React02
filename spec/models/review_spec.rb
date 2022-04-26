require "rails_helper"

RSpec.describe Review, type: :model do
  it "belongs to a brand" do
    t = described_class.reflect_on_association(:brand)
    expect(t.macro).to eq(:belongs_to)
  end
end
