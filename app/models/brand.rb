class Brand < ApplicationRecord
  has_many :reviews, dependent: :destroy
  before_create :slugify

  def average_score
    reviews.average(:score).round(2).to_f
  end

  private

    def slugify
      self.slug = name.parameterize
    end
end
