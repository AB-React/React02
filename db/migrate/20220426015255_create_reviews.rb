class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews, id: :uuid do |t|
      t.string :title
      t.string :description
      t.integer :score
      t.references :brand, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
