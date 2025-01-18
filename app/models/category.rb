class Category < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :recipes, through: :bookmarks

  validates :name, presence: true, uniqueness: true

  has_one_attached :photo
end
