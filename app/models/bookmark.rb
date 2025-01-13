class Bookmark < ApplicationRecord
  belongs_to :recipe
  belongs_to :category

  #validates :category_id, presence: true
  validates :recipe_id, uniqueness: { scope: :category_id, message: "and category pairing must be unique" }
  validates :comment, presence: true, length: { minimum: 6, too_short: "must have at least 6 characters" }
end
