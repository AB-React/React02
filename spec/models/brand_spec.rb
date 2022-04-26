require 'rails_helper'

RSpec.describe Brand, type: :model do
  it "has many reviews" do
    t = Brand.reflect_on_association(:reviews)
    expect(t.macro).to eq(:has_many)
  end
end
