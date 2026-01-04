class Note < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true

  scope :favorites, -> { where(favorite: true) }
end
