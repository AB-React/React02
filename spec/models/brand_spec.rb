require "rails_helper"

RSpec.describe Brand, type: :model do
  it "has many reviews" do
    t = described_class.reflect_on_association(:reviews)
    expect(t.macro).to eq(:has_many)
  end

  describe "#slugify" do
    it "converts a name to slug before save" do
      b = FactoryBot.create(:brand, name: "this is a test")
      expect(b.slug).to eq "this-is-a-test"
    end
  end

  describe "#average_score" do
    it "gives the average score of reviews for the brand" do
      b = FactoryBot.create(:brand)
      FactoryBot.create(:review, brand: b, score: 1)
      FactoryBot.create(:review, brand: b, score: 5)
      expect(b.average_score).to eq(3)
      FactoryBot.create(:review, brand: b, score: 2)
      expect(b.average_score).to eq(2.67)
    end
  end
end
